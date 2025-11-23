impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct Codec {}

impl Codec {
    pub fn new() -> Self {
        Codec {}
    }

    // Serializes a tree to a single string.
    pub fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = String::new();
        self.serialize_helper(root, &mut result);
        result
    }

    fn serialize_helper(
        &self,
        root: Option<Rc<RefCell<TreeNode>>>,
        result: &mut String,
    ) {
        match root {
            Some(node) => {
                let node_ref = node.borrow();
                result.push_str(&node_ref.val.to_string());
                result.push(',');
                self.serialize_helper(node_ref.left.clone(), result);
                self.serialize_helper(node_ref.right.clone(), result);
            }
            None => {
                result.push_str("null,");
            }
        }
    }

    // Deserializes your encoded data to tree.
    pub fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes = data.split(',').peekable();
        self.deserialize_helper(&mut nodes)
    }

    fn deserialize_helper(
        &self,
        nodes: &mut std::iter::Peekable<std::str::Split<'_, '_>>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if nodes.peek().is_none() {
            return None;
        }

        let val = nodes.next().unwrap();
        if val == "null" {
            return None;
        }

        let node = Rc::new(RefCell::new(TreeNode {
            val: val.parse().unwrap(),
            left: self.deserialize_helper(nodes),
            right: self.deserialize_helper(nodes),
        }));

        Some(node)
    }
}
}