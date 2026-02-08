use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn tree2str(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> String {
            if let Some(n) = node {
                let n = n.borrow();
                let left = helper(&n.left);
                let right = helper(&n.right);
                if left.is_empty() && right.is_empty() {
                    format!("{}", n.val)
                } else if right.is_empty() {
                    format!("{}({})", n.val, left)
                } else {
                    format!("{}({})({})", n.val, left, right)
                }
            } else {
                String::new()
            }
        }
        helper(&root)
    }
}