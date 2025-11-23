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

struct Solution;

impl Solution {
    // Helper function to merge two sorted vectors (left_arr and right_arr)
    // and count inversions where an element from left_arr is greater than an element from right_arr.
    // Returns (inversions_count, merged_sorted_vector).
    // The `inversions_count` here specifically refers to pairs (a, b) such that a is from left_arr,
    // b is from right_arr, and a > b.
    fn merge_and_count_inversions(mut left_arr: Vec<i32>, mut right_arr: Vec<i32>) -> (i64, Vec<i32>) {
        let mut merged = Vec::with_capacity(left_arr.len() + right_arr.len());
        let mut inversions = 0;
        let mut i = 0;
        let mut j = 0;

        while i < left_arr.len() && j < right_arr.len() {
            if left_arr[i] <= right_arr[j] {
                merged.push(left_arr[i]);
                i += 1;
            } else {
                merged.push(right_arr[j]);
                // If right_arr[j] is smaller than left_arr[i], it forms an inversion
                // with left_arr[i] and all subsequent elements in left_arr.
                inversions += (left_arr.len() - i) as i64;
                j += 1;
            }
        }

        while i < left_arr.len() {
            merged.push(left_arr[i]);
            i += 1;
        }
        while j < right_arr.len() {
            merged.push(right_arr[j]);
            j += 1;
        }

        (inversions, merged)
    }

    // DFS function that recursively processes the tree.
    // It returns a sorted vector of all values in its subtree.
    // It also accumulates the total sum of inversions for all subtrees in `total_sum`.
    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, total_sum: &mut i64) -> Vec<i32> {
        if let Some(node_rc) = node_opt {
            let mut node = node_rc.borrow_mut();

            // Recursively get sorted values from left and right children.
            // The recursive calls also update `total_sum` with inversions from their respective subtrees.
            let left_sorted_values = Self::dfs(node.left.take(), total_sum);
            let right_sorted_values = Self::dfs(node.right.take(), total_sum);

            // Calculate inversions for the current node's subtree.
            // This involves inversions:
            // 1. Between elements of the left and right subtrees (L, R) where L_val > R_val.
            // 2. Between elements of (Left U Right) and the current node's value (X, V) where X_val > V_val.
            // 3. Between the current node's value and elements of (Left U Right) (V, X) where V_val > X_val.

            // Step 1: Merge left_sorted_values and right_sorted_values.
            // This counts inversions (L_val, R_val) where L_val > R_val.
            let (inversions_left_right, merged_children_values) =
                Self::merge_and_count_inversions(left_sorted_values, right_sorted_values);

            // Step 2 & 3: Merge the combined children's values with the current node's value.
            // We need to count inversions where one element is `node.val` and the other is from `merged_children_values`.
            // The `merge_and_count_inversions` function counts (A_val, B_val) where A_val > B_val.
            // So, `merge_and_count_inversions(merged_children_values, vec![node.val])` counts (X_val, V_val) where X_val > V_val.
            // And `merge_and_count_inversions(vec![node.val], merged_children_values)` counts (V_val, X_val) where V_val > X_val.

            // To get all inversions involving node.val and its children's values, we can perform two merges:
            // 1. Merge `merged_children_values` with `vec![node.val]`. This counts (X, V) where X > V.
            let (inversions_children_vs_node, temp_merged_1) =
                Self::merge_and_count_inversions(merged_children_values, vec![node.val]);

            // 2. Merge `vec![node.val]` with `temp_merged_1` (which is `(Left U Right U {V})` sorted).
            // This counts (V, X) where V > X.
            // However, this approach is tricky because `temp_merged_1` already contains `node.val`.
            // A simpler way:
            // `inversions_children_vs_node` directly counts `(X, V)` where `X` is from `L U R` and `X > V`.
            // `inversions_node_vs_children` directly counts `(V, X)` where `X` is from `L U R` and `V > X`.
            // We need to perform these counts, and then merge everything into a single sorted list.

            // Let's use the single-pass merge for `(L U R)` and then for `(L U R U {V})`.
            // The total inversions for the current node's subtree are:
            // `inversions_left_right` (L_val > R_val)
            // `inversions_between_merged_children_and_node_val` (X_val > V_val OR V_val > X_val)
            // The `merge_and_count_inversions(A, B)` function correctly counts all inversions where an element from `A` is greater than an element from `B`.
            // So, `inversions_left_right` counts all `(l, r)` where `l \in L, r \in R, l > r`.
            // To get all inversions where `node.val` is involved with any element `x` from `L U R`:
            // We need `(x, node.val)` where `x > node.val` AND `(node.val, x)` where `node.val > x`.
            // This is exactly what `merge_and_count_inversions(merged_children_values, vec![node.val])` would give if `merged_children_values` was the "left" list conceptually, and `vec![node.val]` was the "right" list.
            // The `merge_and_count_inversions` function is designed to count all inversions between elements of `left_arr` and `right_arr`.

            // Let `L_values = left_sorted_values`, `R_values = right_sorted_values`, `V_value = node.val`.
            // Total inversions for current subtree = `inv(L_values, R_values) + inv(L_values, V_value) + inv(R_values, V_value)`.
            // Note: `inv(A, B)` means count of pairs `(a, b)` where `a \in A, b \in B, a > b`.

            let mut current_subtree_inversions = 0;

            // Inversions between left and right subtrees
            let (inv_lr, merged_lr) = Self::merge_and_count_inversions(left_sorted_values, right_sorted_values);
            current_subtree_inversions += inv_lr;

            // Inversions where an element from left subtree is greater than node.val
            let (inv_l_v, _) = Self::merge_and_count_inversions(left_sorted_values, vec![node.val]);
            current_subtree_inversions += inv_l_v;

            // Inversions where an element from right subtree is greater than node.val
            let (inv_r_v, _) = Self::merge_and_count_inversions(right_sorted_values, vec![node.val]);
            current_subtree_inversions += inv_r_v;

            // Inversions where node.val is greater than an element from left subtree
            let (inv_v_l, _) = Self::merge_and_count_inversions(vec![node.val], left_sorted_values);
            current_subtree_inversions += inv_v_l;

            // Inversions where node.val is greater than an element from right subtree
            let (inv_v_r, _) = Self::merge_and_count_inversions(vec![node.val], right_sorted_values);
            current_subtree_inversions += inv_v_r;

            // Add the total inversions for THIS subtree to the overall sum.
            // The inversions *within* left and right subtrees are already added by recursive calls.
            *total_sum += current_subtree_inversions;

            // Finally, merge all three components (left, right, current node) into a single sorted list to return.
            // This can be done by merging `merged_lr` with `vec![node.val]`.
            // The inversion count from this final merge is not directly added to `current_subtree_inversions`
            // because we've already calculated all necessary cross-inversions.
            let (_, final_subtree_values) = Self::merge_and_count_inversions(merged_lr, vec![node.val]);

            final_subtree_values
        } else {
            Vec::new()
        }
    }

    pub fn subtree_inversion_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i64 {
        let mut total_overall_inversion_sum = 0;
        Self::dfs(root, &mut total_overall_inversion_sum);
        total_overall_inversion_sum
    }
}