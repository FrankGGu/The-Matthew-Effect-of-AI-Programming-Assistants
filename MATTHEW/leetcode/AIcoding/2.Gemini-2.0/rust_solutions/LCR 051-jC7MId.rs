use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
            match node {
                None => 0,
                Some(n) => {
                    let node = n.borrow();
                    let left = std::cmp::max(dfs(&node.left, max_sum), 0);
                    let right = std::cmp::max(dfs(&node.right, max_sum), 0);
                    *max_sum = std::cmp::max(*max_sum, node.val + left + right);
                    node.val + std::cmp::max(left, right)
                }
            }
        }
        dfs(&root, &mut max_sum);
        max_sum
    }
}