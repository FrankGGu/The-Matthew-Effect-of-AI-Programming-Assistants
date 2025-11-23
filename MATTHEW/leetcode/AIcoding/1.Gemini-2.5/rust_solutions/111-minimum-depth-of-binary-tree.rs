use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn min_depth(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut queue: VecDeque<(Rc<RefCell<TreeNode>>, i32)> = VecDeque::new();
        queue.push_back((root.unwrap(), 1));

        while let Some((node_rc, depth)) = queue.pop_front() {
            let node = node_rc.borrow();

            if node.left.is_none() && node.right.is_none() {
                return depth;
            }

            if let Some(left_child_rc) = node.left.clone() {
                queue.push_back((left_child_rc, depth + 1));
            }
            if let Some(right_child_rc) = node.right.clone() {
                queue.push_back((right_child_rc, depth + 1));
            }
        }

        // This line should theoretically not be reached if the input tree is valid
        // and not empty, as a leaf node will always be found.
        0 
    }
}