use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn bst_from_preorder(preorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut index = 0;
        Self::helper(&preorder, &mut index, i32::MAX)
    }

    fn helper(preorder: &[i32], index: &mut usize, bound: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= preorder.len() || preorder[*index] > bound {
            return None;
        }
        let val = preorder[*index];
        *index += 1;
        let mut node = TreeNode::new(val);
        node.left = Self::helper(preorder, index, val);
        node.right = Self::helper(preorder, index, bound);
        Some(Rc::new(RefCell::new(node)))
    }
}