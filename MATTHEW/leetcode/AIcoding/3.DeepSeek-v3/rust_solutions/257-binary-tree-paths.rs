use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn binary_tree_paths(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<String> {
        let mut paths = Vec::new();
        let mut current_path = String::new();
        Self::dfs(&root, &mut current_path, &mut paths);
        paths
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, current_path: &mut String, paths: &mut Vec<String>) {
        if let Some(n) = node {
            let node = n.borrow();
            let val_str = node.val.to_string();
            let original_len = current_path.len();

            if !current_path.is_empty() {
                current_path.push_str("->");
            }
            current_path.push_str(&val_str);

            if node.left.is_none() && node.right.is_none() {
                paths.push(current_path.clone());
            } else {
                Self::dfs(&node.left, current_path, paths);
                Self::dfs(&node.right, current_path, paths);
            }

            current_path.truncate(original_len);
        }
    }
}