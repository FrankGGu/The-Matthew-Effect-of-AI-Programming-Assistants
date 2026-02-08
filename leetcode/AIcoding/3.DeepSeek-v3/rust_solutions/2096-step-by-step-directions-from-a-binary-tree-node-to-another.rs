use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_directions(root: Option<Rc<RefCell<TreeNode>>>, start_value: i32, dest_value: i32) -> String {
        fn find_path(root: Option<Rc<RefCell<TreeNode>>>, value: i32, path: &mut Vec<char>) -> bool {
            if let Some(node) = root {
                let node = node.borrow();
                if node.val == value {
                    return true;
                }
                if find_path(node.left.clone(), value, path) {
                    path.push('L');
                    return true;
                }
                if find_path(node.right.clone(), value, path) {
                    path.push('R');
                    return true;
                }
            }
            false
        }

        let mut start_path = Vec::new();
        let mut dest_path = Vec::new();
        find_path(root.clone(), start_value, &mut start_path);
        find_path(root.clone(), dest_value, &mut dest_path);

        start_path.reverse();
        dest_path.reverse();

        let mut i = 0;
        while i < start_path.len() && i < dest_path.len() && start_path[i] == dest_path[i] {
            i += 1;
        }

        let mut result = String::new();
        for _ in i..start_path.len() {
            result.push('U');
        }
        for &c in dest_path[i..].iter() {
            result.push(c);
        }

        result
    }
}