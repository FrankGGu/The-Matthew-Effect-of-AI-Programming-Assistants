use std::cell::RefCell;
use std::rc::Rc;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl Solution {
    pub fn count_pairs(root: Option<Rc<RefCell<TreeNode>>>, distance: i32) -> i32 {
        let mut result = 0;
        let distance = distance as usize;

        fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, distance: usize, result: &mut i32) -> Vec<usize> {
            if node.is_none() {
                return vec![];
            }
            let node = node.unwrap().borrow();
            let mut left_counts = dfs(node.left.as_ref(), distance, result);
            let mut right_counts = dfs(node.right.as_ref(), distance, result);

            for &l in &left_counts {
                for &r in &right_counts {
                    if l + r + 2 <= distance {
                        *result += 1;
                    }
                }
            }
            let mut counts = left_counts;
            counts.extend(right_counts);
            counts.push(1);
            counts.retain(|&x| x + 1 <= distance);
            counts
        }

        dfs(root.as_ref(), distance as usize, &mut result);
        result
    }
}