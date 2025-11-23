use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn count_pairs(root: Option<Rc<RefCell<TreeNode>>>, distance: i32) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, distance: i32, count: &mut i32) -> Vec<i32> {
            if let Some(n) = node {
                let n_ref = n.borrow();
                if n_ref.left.is_none() && n_ref.right.is_none() {
                    return vec![1];
                }

                let mut left_leaves = dfs(&n_ref.left, distance, count);
                let mut right_leaves = dfs(&n_ref.right, distance, count);

                for &l in &left_leaves {
                    for &r in &right_leaves {
                        if l + r <= distance {
                            *count += 1;
                        }
                    }
                }

                left_leaves.iter_mut().for_each(|x| *x += 1);
                right_leaves.iter_mut().for_each(|x| *x += 1);

                let mut result = Vec::new();
                result.extend(left_leaves.into_iter().filter(|&x| x <= distance));
                result.extend(right_leaves.into_iter().filter(|&x| x <= distance));
                return result;
            } else {
                return Vec::new();
            }
        }

        let mut count = 0;
        dfs(&root, distance, &mut count);
        count
    }
}