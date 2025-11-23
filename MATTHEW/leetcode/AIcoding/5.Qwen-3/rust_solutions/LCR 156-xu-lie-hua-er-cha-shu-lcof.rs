impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct Solution {}

impl Solution {
    pub fn serialize(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = Vec::new();
        Self::serialize_helper(root, &mut result);
        result.join(",")
    }

    fn serialize_helper(
        root: Option<Rc<RefCell<TreeNode>>>,
        result: &mut Vec<String>,
    ) {
        match root {
            Some(node) => {
                result.push(node.borrow().val.to_string());
                Self::serialize_helper(node.borrow().left.clone(), result);
                Self::serialize_helper(node.borrow().right.clone(), result);
            }
            None => {
                result.push("null".to_string());
            }
        }
    }

    pub fn deserialize(data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes: Vec<&str> = data.split(',').collect();
        Self::deserialize_helper(&nodes, &mut 0)
    }

    fn deserialize_helper(nodes: &[&str], index: &mut usize) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= nodes.len() {
            return None;
        }

        let val = nodes[*index];
        *index += 1;

        if val == "null" {
            return None;
        }

        let node = Rc::new(RefCell::new(TreeNode {
            val: val.parse().unwrap(),
            left: Self::deserialize_helper(nodes, index),
            right: Self::deserialize_helper(nodes, index),
        }));

        Some(node)
    }
}
}