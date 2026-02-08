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
                result.push(',');
                self.serialize_helper(node.borrow().left.clone(), result);
                self.serialize_helper(node.borrow().right.clone(), result);
            }
            None => {
                result.push_str("null,");
            }
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let values: Vec<&str> = data.split(',').collect();
        let mut iter = values.into_iter();
        self.deserialize_helper(&mut iter)
    }

    fn deserialize_helper<'a>(
        &self,
        iter: &mut std::vec::IntoIter<&'a str>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        match iter.next() {
            Some("null") => None,
            Some(val) => {
                let node = Rc::new(RefCell::new(TreeNode::new(val.parse().unwrap())));
                node.borrow_mut().left = self.deserialize_helper(iter);
                node.borrow_mut().right = self.deserialize_helper(iter);
                Some(node)
            }
            None => None,
        }
    }
}

))),
            right: Some(Rc::new(RefCell::new(TreeNode {
                val: 3,
                left: Some(Rc::new(RefCell::new(TreeNode {
                    val: 4,
                    left: None,
                    right: None,
                }))),
                right: Some(Rc::new(RefCell::new(TreeNode {
                    val: 5,
                    left: None,
                    right: None,
                }))),
            }))),
        })));

        let codec = Codec::new();
        let serialized = codec.serialize(root.clone());
        let deserialized = codec.deserialize(serialized);

        assert_eq!(deserialized, root);
    }
}