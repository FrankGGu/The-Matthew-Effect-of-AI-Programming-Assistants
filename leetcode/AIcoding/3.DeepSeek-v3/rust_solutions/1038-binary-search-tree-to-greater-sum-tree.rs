use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn bst_to_gst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut sum = 0;
        Self::reverse_inorder(&root, &mut sum);
        root
    }

    fn reverse_inorder(node: &Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) {
        if let Some(n) = node {
            let mut node = n.borrow_mut();
            Self::reverse_inorder(&node.right, sum);
            *sum += node.val;
            node.val = *sum;
            Self::reverse_inorder(&node.left, sum);
        }
    }
}