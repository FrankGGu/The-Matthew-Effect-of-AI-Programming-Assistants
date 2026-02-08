use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_zigzag_path(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_len = 0;
        Self::dfs_helper(root, &mut max_len);
        max_len
    }

    // This helper function returns a tuple (left_path_len, right_path_len)
    // where:
    // - left_path_len: The length of the longest zigzag path starting from the current node
    //                  and going left first.
    // - right_path_len: The length of the longest zigzag path starting from the current node
    //                   and going right first.
    // The `max_len` parameter is updated with the overall maximum path found so far.
    fn dfs_helper(node_opt: Option<Rc<RefCell<TreeNode>>>, max_len: &mut i32) -> (i32, i32) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();

            // Recursively get path lengths for left and right children
            let (left_res_left_child, right_res_left_child) = Self::dfs_helper(node.left.clone(), max_len);
            let (left_res_right_child, right_res_right_child) = Self::dfs_helper(node.right.clone(), max_len);

            // Calculate the longest zigzag path starting from the current node and going left
            // This path must continue from the left child by going right.
            let current_left_path = 1 + right_res_left_child;

            // Calculate the longest zigzag path starting from the current node and going right
            // This path must continue from the right child by going left.
            let current_right_path = 1 + left_res_right_child;

            // Update the global maximum length
            *max_len = (*max_len)
                .max(current_left_path)
                .max(current_right_path);

            // Return the path lengths starting from this node
            (current_left_path, current_right_path)
        } else {
            // Base case: If the node is None, return 0 for both path types.
            // A path of length 0 means no edges, which is consistent with the definition
            // that 1 is added for each edge.
            (0, 0)
        }
    }
}