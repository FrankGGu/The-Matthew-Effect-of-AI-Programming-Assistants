use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::helper(&preorder, &inorder)
    }

    fn helper(preorder: &[i32], inorder: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if preorder.is_empty() || inorder.is_empty() {
            return None;
        }
        let root_val = preorder[0];
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));
        let pos = inorder.iter().position(|&x| x == root_val).unwrap();
        root.borrow_mut().left = Self::helper(&preorder[1..=pos], &inorder[..pos]);
        root.borrow_mut().right = Self::helper(&preorder[pos+1..], &inorder[pos+1..]);
        Some(root)
    }
}