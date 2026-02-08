use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
  pub val: i32,
  pub left: Option<Rc<RefCell<TreeNode>>>,
  pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
  #[inline]
  pub fn new(val: i32) -> Self {
    TreeNode {
      val,
      left: None,
      right: None
    }
  }
}

impl Solution {
    pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
        let mut x_info: Option<(i32, i32)> = None; // (depth, parent_val)
        let mut y_info: Option<(i32, i32)> = None; // (depth, parent_val)

        // DFS helper function to find depth and parent of target nodes
        fn dfs(
            node: Option<Rc<RefCell<TreeNode>>>,
            parent_val: i32,
            depth: i32,
            target_x: i32,
            target_y: i32,
            x_info_ref: &mut Option<(i32, i32)>,
            y_info_ref: &mut Option<(i32, i32)>,
        ) {
            if node.is_none() {
                return;
            }

            // If both targets are already found, we can stop further traversal
            if x_info_ref.is_some() && y_info_ref.is_some() {
                return;
            }

            let node_rc = node.as_ref().unwrap();
            let node_borrow = node_rc.borrow();
            let current_val = node_borrow.val;

            if current_val == target_x {
                *x_info_ref = Some((depth, parent_val));
            } else if current_val == target_y {
                *y_info_ref = Some((depth, parent_val));
            }

            dfs(
                node_borrow.left.clone(),
                current_val,
                depth + 1,
                target_x,
                target_y,
                x_info_ref,
                y_info_ref,
            );
            dfs(
                node_borrow.right.clone(),
                current_val,
                depth + 1,
                target_x,
                target_y,
                x_info_ref,
                y_info_ref,
            );
        }

        // Start DFS from the root with depth 0 and a sentinel parent value (-1)
        dfs(root, -1, 0, x, y, &mut x_info, &mut y_info);

        // Check the collected information for x and y
        match (x_info, y_info) {
            (Some((x_depth, x_parent)), Some((y_depth, y_parent))) => {
                // Cousins must have the same depth but different parents
                x_depth == y_depth && x_parent != y_parent
            }
            _ => false, // One or both nodes were not found
        }
    }
}