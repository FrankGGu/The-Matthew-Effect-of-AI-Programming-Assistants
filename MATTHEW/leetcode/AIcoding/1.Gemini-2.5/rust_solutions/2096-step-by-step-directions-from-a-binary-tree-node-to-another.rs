use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    fn find_path(node: Option<Rc<RefCell<TreeNode>>>, target: i32, path_str: &mut String) -> bool {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            if n.val == target {
                return true;
            }

            if Self::find_path(n.left.clone(), target, path_str) {
                path_str.push('L');
                return true;
            }
            if Self::find_path(n.right.clone(), target, path_str) {
                path_str.push('R');
                return true;
            }
        }
        false
    }

    pub fn get_directions(root: Option<Rc<RefCell<TreeNode>>>, start_value: i32, dest_value: i32) -> String {
        let mut path_to_start_from_root = String::new();
        Self::find_path(root.clone(), start_value, &mut path_to_start_from_root);
        path_to_start_from_root = path_to_start_from_root.chars().rev().collect();

        let mut path_to_dest_from_root = String::new();
        Self::find_path(root.clone(), dest_value, &mut path_to_dest_from_root);
        path_to_dest_from_root = path_to_dest_from_root.chars().rev().collect();

        let mut common_prefix_len = 0;
        let min_len = path_to_start_from_root.len().min(path_to_dest_from_root.len());
        for i in 0..min_len {
            if path_to_start_from_root.chars().nth(i) == path_to_dest_from_root.chars().nth(i) {
                common_prefix_len += 1;
            } else {
                break;
            }
        }

        let up_steps = path_to_start_from_root.len() - common_prefix_len;
        let mut result = String::new();
        for _ in 0..up_steps {
            result.push('U');
        }

        result.push_str(&path_to_dest_from_root[common_prefix_len..]);

        result
    }
}