use std::cell::RefCell;
use std::rc::Rc;

struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn good_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, max_val: i32) -> i32 {
        if let Some(n) = node {
            let val = n.borrow().val;
            let mut count = 0;
            if val >= max_val {
                count += 1;
            }
            let new_max = max_val.max(val);
            count += dfs(n.borrow().left.as_ref(), new_max);
            count += dfs(n.borrow().right.as_ref(), new_max);
            count
        } else {
            0
        }
    }
    dfs(root.as_ref(), i32::MIN)
}