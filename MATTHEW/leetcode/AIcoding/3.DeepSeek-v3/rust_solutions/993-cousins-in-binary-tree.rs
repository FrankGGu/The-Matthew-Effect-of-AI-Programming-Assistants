use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
        let mut queue = std::collections::VecDeque::new();
        if let Some(node) = root {
            queue.push_back((node, None));
        }

        let mut x_info = None;
        let mut y_info = None;

        while !queue.is_empty() {
            let level_size = queue.len();
            for _ in 0..level_size {
                let (node, parent) = queue.pop_front().unwrap();
                let node_ref = node.borrow();
                let val = node_ref.val;

                if val == x {
                    x_info = parent.map(|p| p.borrow().val);
                }
                if val == y {
                    y_info = parent.map(|p| p.borrow().val);
                }

                if let Some(left) = &node_ref.left {
                    queue.push_back((Rc::clone(left), Some(Rc::clone(&node))));
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back((Rc::clone(right), Some(Rc::clone(&node))));
                }
            }

            if x_info.is_some() || y_info.is_some() {
                return x_info != y_info && x_info.is_some() && y_info.is_some();
            }
        }

        false
    }
}