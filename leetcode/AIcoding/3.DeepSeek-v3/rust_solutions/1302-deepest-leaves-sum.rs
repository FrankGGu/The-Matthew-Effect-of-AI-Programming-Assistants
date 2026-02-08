use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn deepest_leaves_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_depth = 0;
        let mut sum = 0;
        let mut stack = vec![];
        if let Some(node) = root {
            stack.push((node, 0));
        }
        while let Some((node, depth)) = stack.pop() {
            let node = node.borrow();
            if node.left.is_none() && node.right.is_none() {
                if depth > max_depth {
                    max_depth = depth;
                    sum = node.val;
                } else if depth == max_depth {
                    sum += node.val;
                }
            } else {
                if let Some(right) = &node.right {
                    stack.push((Rc::clone(right), depth + 1));
                }
                if let Some(left) = &node.left {
                    stack.push((Rc::clone(left), depth + 1));
                }
            }
        }
        sum
    }
}