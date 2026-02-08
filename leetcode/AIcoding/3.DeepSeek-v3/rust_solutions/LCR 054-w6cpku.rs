use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn convert_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut sum = 0;
        Self::traverse(root.clone(), &mut sum);
        root
    }

    fn traverse(node: Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) {
        if let Some(n) = node {
            let mut n = n.borrow_mut();
            Self::traverse(n.right.clone(), sum);
            *sum += n.val;
            n.val = *sum;
            Self::traverse(n.left.clone(), sum);
        }
    }
}