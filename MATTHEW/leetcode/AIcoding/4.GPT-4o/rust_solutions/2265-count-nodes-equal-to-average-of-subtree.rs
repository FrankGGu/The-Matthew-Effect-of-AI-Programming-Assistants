use std::rc::Rc;
use std::cell::RefCell;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl Solution {
    pub fn average_of_subtree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<&Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            if let Some(n) = node {
                let n = n.borrow();
                let (sum_left, count_left) = dfs(n.left.as_ref());
                let (sum_right, count_right) = dfs(n.right.as_ref());
                let sum = sum_left + sum_right + n.val;
                let count = count_left + count_right + 1;
                let average = sum / count;
                let mut equal_count = if average == n.val { 1 } else { 0 };
                equal_count += (sum_left + sum_right) / (count_left + count_right + 1);
                (sum, count)
            } else {
                (0, 0)
            }
        }

        let mut count = 0;
        fn count_equal(node: Option<&Rc<RefCell<TreeNode>>>, count: &mut i32) -> (i32, i32) {
            if let Some(n) = node {
                let n = n.borrow();
                let (sum_left, count_left) = count_equal(n.left.as_ref(), count);
                let (sum_right, count_right) = count_equal(n.right.as_ref(), count);
                let sum = sum_left + sum_right + n.val;
                let total_count = count_left + count_right + 1;
                if sum / total_count == n.val {
                    *count += 1;
                }
                (sum, total_count)
            } else {
                (0, 0)
            }
        }

        count_equal(root.as_ref(), &mut count);
        count
    }
}