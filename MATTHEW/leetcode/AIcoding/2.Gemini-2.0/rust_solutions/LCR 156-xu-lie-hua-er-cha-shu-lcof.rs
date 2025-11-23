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
        let mut res = String::new();
        let mut queue = Vec::new();

        if root.is_none() {
            return "[]".to_string();
        }

        queue.push(root.clone());

        while !queue.is_empty() {
            let node = queue.remove(0);
            if let Some(n) = node {
                res.push_str(&n.borrow().val.to_string());
                res.push(',');
                queue.push(n.borrow().left.clone());
                queue.push(n.borrow().right.clone());
            } else {
                res.push_str("null,");
            }
        }

        res.pop(); // Remove the last comma
        format!("[{}]", res)
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        if data == "[]" {
            return None;
        }

        let data = data[1..data.len() - 1].to_string();
        let values: Vec<Option<i32>> = data
            .split(',')
            .map(|s| {
                if s == "null" {
                    None
                } else {
                    s.parse::<i32>().ok()
                }
            })
            .collect();

        let root_val = values[0].unwrap();
        let root = Some(Rc::new(RefCell::new(TreeNode::new(root_val))));
        let mut queue = Vec::new();
        queue.push(root.clone());

        let mut i = 1;
        while !queue.is_empty() && i < values.len() {
            let node = queue.remove(0).unwrap();

            if let Some(val) = values[i] {
                let left = Some(Rc::new(RefCell::new(TreeNode::new(val))));
                node.borrow_mut().left = left.clone();
                queue.push(left);
            }
            i += 1;

            if i < values.len() {
                if let Some(val) = values[i] {
                    let right = Some(Rc::new(RefCell::new(TreeNode::new(val))));
                    node.borrow_mut().right = right.clone();
                    queue.push(right);
                }
                i += 1;
            }
        }

        root
    }
}