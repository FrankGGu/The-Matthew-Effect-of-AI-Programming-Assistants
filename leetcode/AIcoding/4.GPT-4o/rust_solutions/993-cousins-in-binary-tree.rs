use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, val: i32, depth: i32, parent: i32, results: &mut Vec<(i32, i32)>) {
        if let Some(n) = node {
            let n = n.borrow();
            if n.val == val {
                results.push((depth, parent));
            }
            dfs(n.left.as_ref(), val, depth + 1, n.val, results);
            dfs(n.right.as_ref(), val, depth + 1, n.val, results);
        }
    }

    let mut x_info = Vec::new();
    let mut y_info = Vec::new();

    dfs(root.as_ref(), x, 0, -1, &mut x_info);
    dfs(root.as_ref(), y, 0, -1, &mut y_info);

    if x_info.len() == 1 && y_info.len() == 1 {
        x_info[0].0 == y_info[0].0 && x_info[0].1 != y_info[0].1
    } else {
        false
    }
}