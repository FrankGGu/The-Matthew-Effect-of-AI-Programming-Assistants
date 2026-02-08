use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn flatten(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        let mut curr = root.clone();
        while let Some(node) = curr {
            let mut node = node.borrow_mut();
            if let Some(left) = node.left.take() {
                let mut rightmost = left.clone();
                while let Some(right) = rightmost.borrow().right.clone() {
                    rightmost = right;
                }
                rightmost.borrow_mut().right = node.right.take();
                node.right = Some(left);
            }
            curr = node.right.clone();
        }
    }
}