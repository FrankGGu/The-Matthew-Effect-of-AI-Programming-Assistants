use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
            match node {
                Some(n) => {
                    let left = dfs(n.borrow().left.clone(), max_sum).max(0);
                    let right = dfs(n.borrow().right.clone(), max_sum).max(0);

                    let price_newpath = n.borrow().val + left + right;
                    *max_sum = (*max_sum).max(price_newpath);

                    n.borrow().val + left.max(right)
                },
                None => 0
            }
        }

        dfs(root, &mut max_sum);
        max_sum
    }
}