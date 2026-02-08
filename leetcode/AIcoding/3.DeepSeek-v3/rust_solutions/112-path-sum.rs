use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn has_path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> bool {
        match root {
            None => false,
            Some(node) => {
                let node = node.borrow();
                let new_sum = target_sum - node.val;
                if node.left.is_none() && node.right.is_none() {
                    new_sum == 0
                } else {
                    Self::has_path_sum(node.left.clone(), new_sum) || Self::has_path_sum(node.right.clone(), new_sum)
                }
            }
        }
    }
}