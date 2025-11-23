use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_even_grandparent(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut sum = 0;
        Self::dfs(&root, None, None, &mut sum);
        sum
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, parent: Option<i32>, grandparent: Option<i32>, sum: &mut i32) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if let Some(gp_val) = grandparent {
                if gp_val % 2 == 0 {
                    *sum += val;
                }
            }
            Self::dfs(&n.borrow().left, Some(val), parent, sum);
            Self::dfs(&n.borrow().right, Some(val), parent, sum);
        }
    }
}