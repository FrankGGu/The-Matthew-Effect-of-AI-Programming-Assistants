use std::rc::Rc;
use std::cell::RefCell;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, sum: i32) -> Vec<Vec<i32>> {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, sum: i32, path: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
        if let Some(n) = node {
            let n = n.borrow();
            path.push(n.val);
            if n.left.is_none() && n.right.is_none() && n.val == sum {
                res.push(path.clone());
            } else {
                dfs(n.left.as_ref(), sum - n.val, path, res);
                dfs(n.right.as_ref(), sum - n.val, path, res);
            }
            path.pop();
        }
    }

    let mut res = Vec::new();
    dfs(root.as_ref(), sum, &mut Vec::new(), &mut res);
    res
}