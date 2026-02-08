use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn count_pairs(root: Option<Rc<RefCell<TreeNode>>>, distance: i32) -> i32 {
        let mut good_pairs_count = 0;
        Self::dfs(root, distance, &mut good_pairs_count);
        good_pairs_count
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, distance: i32, count: &mut i32) -> Vec<i32> {
        let Some(curr_rc) = node else {
            return vec![];
        };
        let curr = curr_rc.borrow();

        if curr.left.is_none() && curr.right.is_none() {
            return vec![1];
        }

        let left_leaf_distances = Self::dfs(curr.left.clone(), distance, count);
        let right_leaf_distances = Self::dfs(curr.right.clone(), distance, count);

        for &ld in &left_leaf_distances {
            for &rd in &right_leaf_distances {
                if ld + rd <= distance {
                    *count += 1;
                }
            }
        }

        let mut current_node_distances = Vec::new();
        for &d in &left_leaf_distances {
            if d + 1 <= distance {
                current_node_distances.push(d + 1);
            }
        }
        for &d in &right_leaf_distances {
            if d + 1 <= distance {
                current_node_distances.push(d + 1);
            }
        }
        current_node_distances
    }
}