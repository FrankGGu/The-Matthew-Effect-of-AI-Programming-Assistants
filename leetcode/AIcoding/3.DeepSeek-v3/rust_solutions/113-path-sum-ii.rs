use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::dfs(&root, target_sum, &mut path, &mut result);
        result
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, remaining_sum: i32, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if let Some(n) = node {
            let node = n.borrow();
            let new_remaining = remaining_sum - node.val;
            path.push(node.val);

            if node.left.is_none() && node.right.is_none() && new_remaining == 0 {
                result.push(path.clone());
            }

            Self::dfs(&node.left, new_remaining, path, result);
            Self::dfs(&node.right, new_remaining, path, result);

            path.pop();
        }
    }
}