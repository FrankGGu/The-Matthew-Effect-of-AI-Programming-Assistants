use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn reverse_odd_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return root;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root.clone());
        let mut level = 0;

        while !queue.is_empty() {
            let len = queue.len();
            let mut nodes = Vec::new();
            let mut vals = Vec::new();

            for _ in 0..len {
                if let Some(node) = queue.pop_front().unwrap() {
                    let node_ref = node.borrow();
                    nodes.push(node.clone());
                    vals.push(node_ref.val);

                    if node_ref.left.is_some() {
                        queue.push_back(node_ref.left.clone());
                    }
                    if node_ref.right.is_some() {
                        queue.push_back(node_ref.right.clone());
                    }
                }
            }

            if level % 2 == 1 {
                vals.reverse();
                for (i, node) in nodes.iter().enumerate() {
                    node.borrow_mut().val = vals[i];
                }
            }

            level += 1;
        }

        root
    }
}