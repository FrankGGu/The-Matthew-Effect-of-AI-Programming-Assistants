use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::helper(&inorder[..], &postorder[..])
    }

    fn helper(inorder: &[i32], postorder: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if inorder.is_empty() {
            return None;
        }
        let root_val = postorder[postorder.len() - 1];
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));
        let idx = inorder.iter().position(|&x| x == root_val).unwrap();
        root.borrow_mut().left = Self::helper(&inorder[..idx], &postorder[..idx]);
        root.borrow_mut().right = Self::helper(&inorder[idx + 1..], &postorder[idx..postorder.len() - 1]);
        Some(root)
    }
}