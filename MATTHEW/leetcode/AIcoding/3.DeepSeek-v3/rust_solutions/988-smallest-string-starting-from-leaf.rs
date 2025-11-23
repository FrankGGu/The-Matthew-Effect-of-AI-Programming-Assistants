use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn smallest_from_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut paths = Vec::new();
        Self::dfs(&root, &mut Vec::new(), &mut paths);
        paths.sort();
        paths.into_iter().next().unwrap_or_default()
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, path: &mut Vec<char>, paths: &mut Vec<String>) {
        if let Some(n) = node {
            let n = n.borrow();
            path.push((b'a' + n.val as u8) as char);
            if n.left.is_none() && n.right.is_none() {
                let s: String = path.iter().rev().collect();
                paths.push(s);
            } else {
                Self::dfs(&n.left, path, paths);
                Self::dfs(&n.right, path, paths);
            }
            path.pop();
        }
    }
}