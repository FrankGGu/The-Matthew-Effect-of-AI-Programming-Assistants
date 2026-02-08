use std::cell::RefCell;
use std::rc::Rc;

struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn distribute_coins(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, moves: &mut i32) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let left = dfs(n.left.as_ref(), moves);
            let right = dfs(n.right.as_ref(), moves);
            *moves += (left.abs() + right.abs());
            n.val + left + right - 1
        } else {
            0
        }
    }
    let mut moves = 0;
    dfs(root.as_ref(), &mut moves);
    moves
}