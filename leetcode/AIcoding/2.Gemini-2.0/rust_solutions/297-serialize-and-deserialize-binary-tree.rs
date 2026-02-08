use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Codec {}

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        fn serialize_helper(root: &Option<Rc<RefCell<TreeNode>>>, result: &mut String) {
            match root {
                Some(node) => {
                    result.push_str(&node.borrow().val.to_string());
                    result.push(',');
                    serialize_helper(&node.borrow().left, result);
                    serialize_helper(&node.borrow().right, result);
                }
                None => {
                    result.push_str("null,");
                }
            }
        }

        let mut result = String::new();
        serialize_helper(&root, &mut result);
        result.pop();
        result
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut values: Vec<&str> = data.split(',').collect();
        fn deserialize_helper(values: &mut Vec<&str>) -> Option<Rc<RefCell<TreeNode>>> {
            if values.is_empty() {
                return None;
            }

            let value = values.remove(0);
            if value == "null" {
                return None;
            }

            let val: i32 = value.parse().unwrap();
            let node = Rc::new(RefCell::new(TreeNode::new(val)));
            node.borrow_mut().left = deserialize_helper(values);
            node.borrow_mut().right = deserialize_helper(values);

            Some(node)
        }

        deserialize_helper(&mut values)
    }
}