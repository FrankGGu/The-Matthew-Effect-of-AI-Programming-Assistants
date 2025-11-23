impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn construct_binary_tree_from_preorder_and_postorder(
    preorder: Vec<i32>,
    postorder: Vec<i32>,
) -> Option<Rc<RefCell<TreeNode>>> {
    fn build(
        preorder: &[i32],
        postorder: &[i32],
        index: &mut usize,
        value_to_index: &std::collections::HashMap<i32, usize>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if preorder.is_empty() {
            return None;
        }

        let root_val = preorder[0];
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));
        *index += 1;

        if preorder.len() == 1 {
            return Some(root);
        }

        let left_root_val = preorder[*index];
        let left_root_pos = value_to_index.get(&left_root_val).copied();

        if let Some(pos) = left_root_pos {
            let left_size = pos - 0;
            let left_subtree = build(
                &preorder[1..1 + left_size],
                &postorder[0..left_size],
                index,
                value_to_index,
            );
            root.borrow_mut().left = left_subtree;
        }

        let right_subtree = build(
            &preorder[*index..],
            &postorder[left_size..],
            index,
            value_to_index,
        );
        root.borrow_mut().right = right_subtree;

        Some(root)
    }

    let value_to_index: std::collections::HashMap<i32, usize> = postorder
        .iter()
        .enumerate()
        .map(|(i, &val)| (val, i))
        .collect();

    let mut index = 0;
    build(&preorder, &postorder, &mut index, &value_to_index)
}
}