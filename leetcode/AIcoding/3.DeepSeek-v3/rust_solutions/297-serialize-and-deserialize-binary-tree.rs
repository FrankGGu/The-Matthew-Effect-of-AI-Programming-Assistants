use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct Codec;

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = String::new();
        let mut queue = VecDeque::new();
        queue.push_back(root);

        while let Some(node) = queue.pop_front() {
            match node {
                Some(n) => {
                    let n = n.borrow();
                    result.push_str(&n.val.to_string());
                    result.push(',');
                    queue.push_back(n.left.clone());
                    queue.push_back(n.right.clone());
                }
                None => {
                    result.push_str("null,");
                }
            }
        }
        result
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes: Vec<&str> = data.split(',').filter(|s| !s.is_empty()).collect();
        if nodes.is_empty() || nodes[0] == "null" {
            return None;
        }

        let root = Rc::new(RefCell::new(TreeNode::new(nodes[0].parse().unwrap())));
        let mut queue = VecDeque::new();
        queue.push_back(root.clone());
        let mut i = 1;

        while let Some(node) = queue.pop_front() {
            if i < nodes.len() {
                if nodes[i] != "null" {
                    let left = Rc::new(RefCell::new(TreeNode::new(nodes[i].parse().unwrap())));
                    node.borrow_mut().left = Some(left.clone());
                    queue.push_back(left);
                }
                i += 1;
            }

            if i < nodes.len() {
                if nodes[i] != "null" {
                    let right = Rc::new(RefCell::new(TreeNode::new(nodes[i].parse().unwrap())));
                    node.borrow_mut().right = Some(right.clone());
                    queue.push_back(right);
                }
                i += 1;
            }
        }
        Some(root)
    }
}

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