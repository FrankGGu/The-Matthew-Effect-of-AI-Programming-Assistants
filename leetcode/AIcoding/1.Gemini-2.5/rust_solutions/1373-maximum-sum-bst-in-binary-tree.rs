use std::rc::Rc;
use std::cell::RefCell;
use std::cmp;

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

struct Solution;

impl Solution {
    pub fn max_sum_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_bst_sum = 0;

        // Helper function returns (is_bst, min_val, max_val, current_sum)
        // - is_bst: true if the current subtree is a BST, false otherwise.
        // - min_val: The minimum value in the current BST subtree. If not a BST, i32::MIN.
        // - max_val: The maximum value in the current BST subtree. If not a BST, i32::MAX.
        // - current_sum: The sum of all nodes in the current BST subtree. If not a BST, 0.
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_bst_sum: &mut i32) -> (bool, i32, i32, i32) {
            match node {
                None => {
                    // An empty tree is a valid BST.
                    // min_val = i32::MAX: Ensures any parent node's value will be less than this, satisfying BST property for left child.
                    // max_val = i32::MIN: Ensures any parent node's value will be greater than this, satisfying BST property for right child.
                    (true, i32::MAX, i32::MIN, 0)
                }
                Some(rc_node) => {
                    let node_ref = rc_node.borrow();
                    let node_val = node_ref.val;

                    // Recursively get information from left and right children
                    let (left_is_bst, left_min, left_max, left_sum) = dfs(node_ref.left.clone(), max_bst_sum);
                    let (right_is_bst, right_min, right_max, right_sum) = dfs(node_ref.right.clone(), max_bst_sum);

                    // Check if the current subtree rooted at node_val is a BST
                    let current_is_bst = left_is_bst
                        && right_is_bst
                        && node_val > left_max
                        && node_val < right_min;

                    if current_is_bst {
                        let current_sum = left_sum + right_sum + node_val;
                        // Update the overall maximum BST sum found so far
                        *max_bst_sum = cmp::max(*max_bst_sum, current_sum);

                        // Calculate the actual min and max values for the current BST subtree
                        let current_min = cmp::min(left_min, node_val);
                        let current_max = cmp::max(right_max, node_val);

                        (true, current_min, current_max, current_sum)
                    } else {
                        // If the current subtree is not a BST, propagate failure.
                        // min_val = i32::MIN and max_val = i32::MAX ensure any parent trying to form a BST
                        // with this subtree will fail its BST condition (e.g., parent_val > max_val or parent_val < min_val).
                        (false, i32::MIN, i32::MAX, 0)
                    }
                }
            }
        }

        dfs(root, &mut max_bst_sum);
        max_bst_sum
    }
}