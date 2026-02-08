use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn subtree_with_all_deepest(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, Option<Rc<RefCell<TreeNode>>>) {
            match node {
                None => (0, None),
                Some(n) => {
                    let (left_depth, left_node) = dfs(&n.borrow().left);
                    let (right_depth, right_node) = dfs(&n.borrow().right);
                    if left_depth > right_depth {
                        (left_depth + 1, left_node)
                    } else if right_depth > left_depth {
                        (right_depth + 1, right_node)
                    } else {
                        (left_depth + 1, Some(Rc::clone(n)))
                    }
                }
            }
        }
        dfs(&root).1
    }
}