use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct Codec;

impl Codec {
    fn new() -> Self {
        Codec
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = String::new();
        let mut queue = VecDeque::new();
        queue.push_back(root);

        while let Some(node) = queue.pop_front() {
            if let Some(n) = node {
                let n = n.borrow();
                result.push_str(&n.val.to_string());
                result.push(',');
                queue.push_back(n.left.clone());
                queue.push_back(n.right.clone());
            } else {
                result.push_str("null,");
            }
        }
        result.pop();
        result
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        if data.is_empty() {
            return None;
        }
        let nodes: Vec<&str> = data.split(',').collect();
        let root_val = nodes[0].parse::<i32>().ok()?;
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));
        let mut queue = VecDeque::new();
        queue.push_back(Rc::clone(&root));
        let mut i = 1;

        while let Some(node) = queue.pop_front() {
            if i < nodes.len() && nodes[i] != "null" {
                let left_val = nodes[i].parse::<i32>().unwrap();
                let left_node = Rc::new(RefCell::new(TreeNode::new(left_val)));
                node.borrow_mut().left = Some(Rc::clone(&left_node));
                queue.push_back(left_node);
            }
            i += 1;
            if i < nodes.len() && nodes[i] != "null" {
                let right_val = nodes[i].parse::<i32>().unwrap();
                let right_node = Rc::new(RefCell::new(TreeNode::new(right_val)));
                node.borrow_mut().right = Some(Rc::clone(&right_node));
                queue.push_back(right_node);
            }
            i += 1;
        }
        Some(root)
    }
}