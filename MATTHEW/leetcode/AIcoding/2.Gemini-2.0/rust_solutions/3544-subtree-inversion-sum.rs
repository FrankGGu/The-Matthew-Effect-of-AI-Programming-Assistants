use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn subtree_inversion_sum(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = vec![];
        Solution::dfs(&root, &mut result);
        result
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<i32>) -> i32 {
        if let Some(n) = node {
            let left_inversions = Solution::dfs(&n.borrow().left, result);
            let right_inversions = Solution::dfs(&n.borrow().right, result);

            let mut inversions = left_inversions + right_inversions;

            if let Some(left) = &n.borrow().left {
                if n.borrow().val > left.borrow().val {
                    inversions += 1;
                }
            }

            if let Some(right) = &n.borrow().right {
                if n.borrow().val > right.borrow().val {
                    inversions += 1;
                }
            }

            result.push(inversions);
            inversions
        } else {
            0
        }
    }
}