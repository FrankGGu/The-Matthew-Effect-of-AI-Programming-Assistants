use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn bst_from_preorder(preorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut index = 0;
        Self::build(&preorder, &mut index, i32::MIN, i32::MAX)
    }

    fn build(preorder: &[i32], index: &mut usize, lower_bound: i32, upper_bound: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= preorder.len() {
            return None;
        }

        let val = preorder[*index];

        if val < lower_bound || val > upper_bound {
            return None;
        }

        *index += 1;
        let mut node = TreeNode::new(val);

        node.left = Self::build(preorder, index, lower_bound, val);
        node.right = Self::build(preorder, index, val, upper_bound);

        Some(Rc::new(RefCell::new(node)))
    }
}