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
    pub fn distribute_coins(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_moves = 0;
        Self::dfs(root, &mut total_moves);
        total_moves
    }

    // This DFS function returns the "balance" of coins for the subtree rooted at `node`.
    // A positive balance means there are excess coins in this subtree that need to move up.
    // A negative balance means this subtree needs coins from its parent.
    // It also accumulates the total moves required within this subtree to `total_moves`.
    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, total_moves: &mut i32) -> i32 {
        if let Some(node_rc) = node {
            let mut node_borrow = node_rc.borrow_mut();

            // Recursively calculate balances for left and right subtrees
            let left_balance = Self::dfs(node_borrow.left.take(), total_moves);
            let right_balance = Self::dfs(node_borrow.right.take(), total_moves);

            // The number of moves required to satisfy the children's needs
            // or to move their excess coins up is the absolute sum of their balances.
            *total_moves += left_balance.abs() + right_balance.abs();

            // Calculate the balance for the current node's subtree:
            // (current node's coins + left subtree's coins + right subtree's coins) - (nodes in this subtree)
            // which simplifies to:
            // current node's coins + left_balance + right_balance - 1 (for the current node itself)
            node_borrow.val + left_balance + right_balance - 1
        } else {
            // An empty subtree has 0 coins and needs 0 coins, so its balance is 0.
            0
        }
    }
}