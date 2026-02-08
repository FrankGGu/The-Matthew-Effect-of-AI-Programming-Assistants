use std::rc::Rc;
use std::cell::RefCell;

type OptNode = Option<Rc<RefCell<TreeNode>>>;

struct Solution;

impl Solution {
    pub fn find_mode(root: OptNode) -> Vec<i32> {
        let mut modes: Vec<i32> = Vec::new();
        if root.is_none() {
            return modes;
        }

        let mut current_val: Option<i32> = None;
        let mut current_count: i32 = 0;
        let mut max_count: i32 = 0;

        // Pass 1: Find the maximum frequency (max_count)
        Self::inorder_traverse(
            root.clone(), // Clone root for the second pass
            &mut current_val,
            &mut current_count,
            &mut max_count,
            &mut modes, // modes is not used for collecting in pass 1
            true, // is_pass1
        );

        // Reset state for Pass 2
        current_val = None;
        current_count = 0;
        modes.clear(); // Clear modes, it's empty for pass 2 collection

        // Pass 2: Collect all values that have a frequency equal to max_count
        Self::inorder_traverse(
            root,
            &mut current_val,
            &mut current_count,
            &mut max_count, // max_count is read-only in pass 2
            &mut modes,
            false, // is_pass1
        );

        modes
    }

    fn inorder_traverse(
        node: OptNode,
        current_val: &mut Option<i32>,
        current_count: &mut i32,
        max_count: &mut i32,
        modes: &mut Vec<i32>,
        is_pass1: bool,
    ) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            // Traverse left subtree
            Self::inorder_traverse(
                n.left.clone(),
                current_val,
                current_count,
                max_count,
                modes,
                is_pass1,
            );

            // Process current node
            if let Some(val) = *current_val {
                if val == n.val {
                    *current_count += 1;
                } else {
                    *current_val = Some(n.val);
                    *current_count = 1;
                }
            } else { // This is the very first node visited in the traversal
                *current_val = Some(n.val);
                *current_count = 1;
            }

            if is_pass1 {
                if *current_count > *max_count {
                    *max_count = *current_count;
                }
            } else { // Pass 2: Collect modes
                if *current_count == *max_count {
                    modes.push(n.val);
                }
            }

            // Traverse right subtree
            Self::inorder_traverse(
                n.right.clone(),
                current_val,
                current_count,
                max_count,
                modes,
                is_pass1,
            );
        }
    }
}