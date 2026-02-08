use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_zigzag(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, go_left: bool, len: i32) -> i32 {
            match node {
                None => len,
                Some(n) => {
                    let node_ref = n.borrow();
                    if go_left {
                        let left = dfs(node_ref.left.clone(), false, len + 1);
                        let right = dfs(node_ref.right.clone(), true, 1);
                        left.max(right)
                    } else {
                        let right = dfs(node_ref.right.clone(), true, len + 1);
                        let left = dfs(node_ref.left.clone(), false, 1);
                        right.max(left)
                    }
                }
            }
        }

        match root {
            None => 0,
            Some(r) => {
                dfs(r.clone(), true, 0).max(dfs(r.clone(), false, 0))
            }
        }
    }
}