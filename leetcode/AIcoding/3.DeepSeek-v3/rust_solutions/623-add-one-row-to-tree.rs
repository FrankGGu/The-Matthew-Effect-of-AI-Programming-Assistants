use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn add_one_row(root: Option<Rc<RefCell<TreeNode>>>, val: i32, depth: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if depth == 1 {
            let new_node = Rc::new(RefCell::new(TreeNode {
                val,
                left: root,
                right: None,
            }));
            return Some(new_node);
        }
        Self::dfs(&root, val, depth - 1);
        root
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, val: i32, depth: i32) {
        if let Some(n) = node {
            let mut n = n.borrow_mut();
            if depth == 1 {
                let left = n.left.take();
                n.left = Some(Rc::new(RefCell::new(TreeNode {
                    val,
                    left,
                    right: None,
                })));
                let right = n.right.take();
                n.right = Some(Rc::new(RefCell::new(TreeNode {
                    val,
                    left: None,
                    right,
                })));
            } else {
                Self::dfs(&n.left, val, depth - 1);
                Self::dfs(&n.right, val, depth - 1);
            }
        }
    }
}