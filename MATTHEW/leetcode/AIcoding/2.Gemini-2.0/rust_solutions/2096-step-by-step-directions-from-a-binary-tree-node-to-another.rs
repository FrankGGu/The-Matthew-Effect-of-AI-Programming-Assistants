use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn get_directions(
        root: Option<Rc<RefCell<TreeNode>>>,
        start_value: i32,
        dest_value: i32,
    ) -> String {
        fn find_path(
            root: Option<Rc<RefCell<TreeNode>>>,
            target: i32,
            path: &mut String,
        ) -> bool {
            if let Some(node) = root {
                let val = node.borrow().val;
                if val == target {
                    return true;
                }
                path.push('L');
                if find_path(node.borrow().left.clone(), target, path) {
                    return true;
                }
                path.pop();
                path.push('R');
                if find_path(node.borrow().right.clone(), target, path) {
                    return true;
                }
                path.pop();
            }
            false
        }

        let mut start_path = String::new();
        find_path(root.clone(), start_value, &mut start_path);

        let mut dest_path = String::new();
        find_path(root.clone(), dest_value, &mut dest_path);

        let mut i = 0;
        while i < start_path.len() && i < dest_path.len() && start_path.chars().nth(i) == dest_path.chars().nth(i) {
            i += 1;
        }

        let mut result = String::new();
        for _ in 0..start_path.len() - i {
            result.push('U');
        }

        result.push_str(&dest_path[i..]);

        result
    }
}