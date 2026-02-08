use std::rc::Rc;
use std::cell::RefCell;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn sum_root_to_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, current_sum: i32) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let new_sum = (current_sum << 1) | n.val;
            if n.left.is_none() && n.right.is_none() {
                return new_sum;
            }
            dfs(n.left.as_ref(), new_sum) + dfs(n.right.as_ref(), new_sum)
        } else {
            0
        }
    }
    dfs(root.as_ref(), 0)
}