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
        let mut result = String::new();
        self.serialize_helper(root, &mut result);
        result
    }

    fn serialize_helper(&self, root: Option<Rc<RefCell<TreeNode>>>, result: &mut String) {
        match root {
            Some(node) => {
                result.push_str(&node.borrow().val.to_string());
                result.push_str(",");
                self.serialize_helper(node.borrow().left.clone(), result);
                self.serialize_helper(node.borrow().right.clone(), result);
            }
            None => {
                result.push_str("null,");
            }
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut values: Vec<&str> = data.split(",").collect();
        values.pop();
        self.deserialize_helper(&mut values)
    }

    fn deserialize_helper(&self, values: &mut Vec<&str>) -> Option<Rc<RefCell<TreeNode>>> {
        if values.is_empty() {
            return None;
        }

        let val_str = values.remove(0);
        if val_str == "null" {
            return None;
        }

        let val = val_str.parse::<i32>().unwrap();
        let node = Rc::new(RefCell::new(TreeNode::new(val)));

        node.borrow_mut().left = self.deserialize_helper(values);
        node.borrow_mut().right = self.deserialize_helper(values);

        Some(node)
    }
}