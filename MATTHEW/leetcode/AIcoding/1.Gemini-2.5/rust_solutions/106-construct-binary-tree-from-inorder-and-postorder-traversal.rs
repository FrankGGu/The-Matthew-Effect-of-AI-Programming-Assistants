use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        if inorder.is_empty() || postorder.is_empty() {
            return None;
        }

        Self::build_recursive(&inorder, &postorder)
    }

    fn build_recursive(inorder: &[i32], postorder: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if inorder.is_empty() || postorder.is_empty() {
            return None;
        }

        let root_val = *postorder.last().unwrap();
        let mut root_node = TreeNode::new(root_val);

        let root_idx_in_inorder = inorder.iter().position(|&x| x == root_val).unwrap();

        let left_inorder = &inorder[0..root_idx_in_inorder];
        let right_inorder = &inorder[root_idx_in_inorder + 1..];

        let left_subtree_size = left_inorder.len();

        let left_postorder = &postorder[0..left_subtree_size];
        let right_postorder = &postorder[left_subtree_size..postorder.len() - 1];

        root_node.left = Self::build_recursive(left_inorder, left_postorder);
        root_node.right = Self::build_recursive(right_inorder, right_postorder);

        Some(Rc::new(RefCell::new(root_node)))
    }
}