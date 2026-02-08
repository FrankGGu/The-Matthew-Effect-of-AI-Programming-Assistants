use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::dfs(&root, target_sum, &mut path, &mut result);
        result
    }

    fn dfs(
        node: &Option<Rc<RefCell<TreeNode>>>,
        remaining_sum: i32,
        path: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if let Some(n) = node {
            let node = n.borrow();
            path.push(node.val);
            let remaining_sum = remaining_sum - node.val;
            if node.left.is_none() && node.right.is_none() && remaining_sum == 0 {
                result.push(path.clone());
            }
            Self::dfs(&node.left, remaining_sum, path, result);
            Self::dfs(&node.right, remaining_sum, path, result);
            path.pop();
        }
    }
}