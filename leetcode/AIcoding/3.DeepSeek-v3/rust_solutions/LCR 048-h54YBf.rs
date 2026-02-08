use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct Codec {}

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut res = vec![];
        let mut queue = VecDeque::new();
        queue.push_back(root);
        while let Some(node) = queue.pop_front() {
            if let Some(n) = node {
                let n = n.borrow();
                res.push(n.val.to_string());
                queue.push_back(n.left.clone());
                queue.push_back(n.right.clone());
            } else {
                res.push("null".to_string());
            }
        }
        res.join(",")
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes: Vec<&str> = data.split(',').collect();
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