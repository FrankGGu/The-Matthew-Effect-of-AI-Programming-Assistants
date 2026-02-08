use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn add_one_row(root: Option<Rc<RefCell<TreeNode>>>, val: i32, depth: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if depth == 1 {
            let new_root = Rc::new(RefCell::new(TreeNode::new(val)));
            new_root.borrow_mut().left = root;
            return Some(new_root);
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        if let Some(r) = root.clone() {
            queue.push_back(r);
        } else {
            return None;
        }

        let mut current_depth = 1;

        while !queue.is_empty() {
            if current_depth == depth - 1 {
                let level_size = queue.len();
                for _ in 0..level_size {
                    let node_rc = queue.pop_front().unwrap();
                    let mut node = node_rc.borrow_mut();

                    let old_left = node.left.take();
                    let old_right = node.right.take();

                    let new_left_node_rc = Rc::new(RefCell::new(TreeNode::new(val)));
                    new_left_node_rc.borrow_mut().left = old_left;

                    let new_right_node_rc = Rc::new(RefCell::new(TreeNode::new(val)));
                    new_right_node_rc.borrow_mut().right = old_right;

                    node.left = Some(new_left_node_rc);
                    node.right = Some(new_right_node_rc);
                }
                return root;
            }

            let level_size = queue.len();
            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();

                if let Some(l_rc) = &node.left {
                    queue.push_back(l_rc.clone());
                }
                if let Some(r_rc) = &node.right {
                    queue.push_back(r_rc.clone());
                }
            }
            current_depth += 1;
        }

        root
    }
}