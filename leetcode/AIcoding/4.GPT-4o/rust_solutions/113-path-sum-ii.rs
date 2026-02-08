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
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, target_sum: i32, path: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
            if let Some(n) = node {
                let n = n.borrow();
                path.push(n.val);
                if n.left.is_none() && n.right.is_none() && n.val == target_sum {
                    res.push(path.clone());
                } else {
                    dfs(n.left.clone(), target_sum - n.val, path, res);
                    dfs(n.right.clone(), target_sum - n.val, path, res);
                }
                path.pop();
            }
        }

        let mut res = Vec::new();
        let mut path = Vec::new();
        dfs(root, target_sum, &mut path, &mut res);
        res
    }
}