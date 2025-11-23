use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

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
    pub fn del_nodes(root: Option<Rc<RefCell<TreeNode>>>, to_delete: Vec<i32>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let to_delete_set: HashSet<i32> = to_delete.into_iter().collect();
        let mut result_forest: Vec<Option<Rc<RefCell<TreeNode>>>> = Vec::new();

        // The DFS function processes a node and its children.
        // It returns an Option<Rc<RefCell<TreeNode>>>:
        // - Some(node_rc) if the current node (and its subtree) should remain connected to its parent.
        // - None if the current node was deleted (or was null).
        // This function takes ownership of `node_option` and returns ownership of `Rc<RefCell<TreeNode>>` if not deleted.
        fn dfs(
            node_option: Option<Rc<RefCell<TreeNode>>>,
            to_delete_set: &HashSet<i32>,
            result_forest: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
        ) -> Option<Rc<RefCell<TreeNode>>> {
            if node_option.is_none() {
                return None;
            }

            // Take ownership of the Rc from the Option to work with it
            let node_rc = node_option.unwrap();
            let mut node_borrow = node_rc.borrow_mut(); // Mutably borrow the TreeNode inside the RefCell

            // Recursively process children
            // `take()` moves the Option out of the field, leaving None behind.
            // The result of the DFS call (an Option<Rc<RefCell<TreeNode>>>) is then assigned back.
            node_borrow.left = dfs(node_borrow.left.take(), to_delete_set, result_forest);
            node_borrow.right = dfs(node_borrow.right.take(), to_delete_set, result_forest);

            // Check if the current node needs to be deleted
            if to_delete_set.contains(&node_borrow.val) {
                // If this node is deleted, its children become new roots if they exist
                // `take()` moves the Option out of the field, leaving None behind.
                // These `Option<Rc<RefCell<TreeNode>>>` are then pushed to the result_forest.
                if node_borrow.left.is_some() {
                    result_forest.push(node_borrow.left.take());
                }
                if node_borrow.right.is_some() {
                    result_forest.push(node_borrow.right.take());
                }
                // This node itself is deleted, so return None to its parent.
                // The `node_rc` (which was `node_option.unwrap()`) will be dropped here,
                // decrementing its strong count.
                None
            } else {
                // This node is not deleted, so return it to its parent.
                // `node_rc` is moved out of this function's scope to be held by the parent's `left` or `right` field.
                // Its strong count remains unchanged as it's just being moved.
                Some(node_rc)
            }
        }

        // Call DFS on the root of the initial tree
        let final_root_option = dfs(root, &to_delete_set, &mut result_forest);

        // If the original root itself was not deleted, it should be part of the forest.
        if final_root_option.is_some() {
            result_forest.push(final_root_option);
        }

        result_forest
    }
}