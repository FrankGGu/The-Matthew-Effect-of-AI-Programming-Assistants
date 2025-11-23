use std::cell::RefCell;
use std::rc::Rc;

struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution {
    max_sum: i32,
}

impl Solution {
    pub fn max_sum_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut solution = Solution { max_sum: 0 };
        solution.dfs(root);
        solution.max_sum
    }

    fn dfs(&mut self, node: Option<Rc<RefCell<TreeNode>>>) -> (bool, i32, i32, i32) {
        if let Some(n) = node {
            let n = n.borrow();
            let left = self.dfs(n.left.clone());
            let right = self.dfs(n.right.clone());

            if left.0 && right.0 && n.val > left.2 && n.val < right.1 {
                let sum = n.val + left.1 + right.1;
                self.max_sum = self.max_sum.max(sum);
                return (true, sum, n.val, right.2);
            }
            return (false, 0, 0, 0);
        }
        (true, 0, i32::MAX, i32::MIN)
    }
}