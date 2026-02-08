use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn distribute_coins(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut moves = 0;
        Self::dfs(&root, &mut moves);
        moves
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, moves: &mut i32) -> i32 {
        if let Some(n) = node {
            let node_ref = n.borrow();
            let left = Self::dfs(&node_ref.left, moves);
            let right = Self::dfs(&node_ref.right, moves);
            *moves += left.abs() + right.abs();
            node_ref.val + left + right - 1
        } else {
            0
        }
    }
}