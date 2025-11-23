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
        Self {}
    }

    // Serializes a tree to a single string.
    pub fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = Vec::new();
        self.preorder_serialize(root, &mut result);
        result.join(",")
    }

    fn preorder_serialize(
        &self,
        node: Option<Rc<RefCell<TreeNode>>>,
        result: &mut Vec<String>,
    ) {
        match node {
            Some(n) => {
                let node = n.borrow();
                result.push(node.val.to_string());
                self.preorder_serialize(node.left.clone(), result);
                self.preorder_serialize(node.right.clone(), result);
            }
            None => {
                result.push("N".to_string());
            }
        }
    }

    // Deserializes your encoded data to tree.
    pub fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes: Vec<&str> = data.split(',').collect();
        let mut index = 0;
        self.preorder_deserialize(&nodes, &mut index)
    }

    fn preorder_deserialize(
        &self,
        nodes: &[&str],
        index: &mut usize,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= nodes.len() {
            return None;
        }

        let val = nodes[*index];
        *index += 1;

        if val == "N" {
            return None;
        }

        let node = Rc::new(RefCell::new(TreeNode {
            val: val.parse().unwrap(),
            left: self.preorder_deserialize(nodes, index),
            right: self.preorder_deserialize(nodes, index),
        }));

        Some(node)
    }
}
}