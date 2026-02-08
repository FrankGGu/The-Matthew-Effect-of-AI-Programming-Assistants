use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn binary_tree_paths(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        if root.is_none() {
            return result;
        }

        Self::dfs(root, String::new(), &mut result);
        result
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_path: String, result: &mut Vec<String>) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let new_path = if current_path.is_empty() {
                format!("{}", n.val)
            } else {
                format!("{}->{}", current_path, n.val)
            };

            if n.left.is_none() && n.right.is_none() {
                result.push(new_path);
            } else {
                Self::dfs(n.left.clone(), new_path.clone(), result);
                Self::dfs(n.right.clone(), new_path.clone(), result);
            }
        }
    }
}