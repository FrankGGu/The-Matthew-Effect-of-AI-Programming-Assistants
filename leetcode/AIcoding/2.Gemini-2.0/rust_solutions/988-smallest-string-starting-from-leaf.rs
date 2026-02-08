use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn smallest_from_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, path: &mut Vec<char>) -> String {
            match node {
                None => {
                    let mut s: String = path.iter().rev().collect();
                    s
                }
                Some(n) => {
                    let node = n.borrow();
                    let c = (node.val as u8 + b'a') as char;
                    path.push(c);

                    let left_result = dfs(&node.left, path);
                    let right_result = dfs(&node.right, path);

                    path.pop();

                    if node.left.is_none() && node.right.is_none() {
                        let mut s: String = path.iter().rev().collect();
                        s.push(c);
                        return s;
                    }

                    if node.left.is_none() {
                        return right_result;
                    }

                    if node.right.is_none() {
                        return left_result;
                    }

                    if left_result < right_result {
                        left_result
                    } else {
                        right_result
                    }
                }
            }
        }

        let mut path: Vec<char> = Vec::new();
        dfs(&root, &mut path)
    }
}