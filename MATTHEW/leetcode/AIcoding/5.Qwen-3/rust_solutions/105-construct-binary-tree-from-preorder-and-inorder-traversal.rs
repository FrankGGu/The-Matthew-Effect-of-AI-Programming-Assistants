impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
    fn build(
        preorder: &[i32],
        inorder: &[i32],
        index_map: &std::collections::HashMap<i32, usize>,
        pre_start: usize,
        in_start: usize,
        in_end: usize,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if pre_start >= preorder.len() || in_start > in_end {
            return None;
        }

        let root_val = preorder[pre_start];
        let root_index = index_map[&root_val];

        let left_subtree_size = root_index - in_start;

        let left = build(
            preorder,
            inorder,
            index_map,
            pre_start + 1,
            in_start,
            root_index - 1,
        );
        let right = build(
            preorder,
            inorder,
            index_map,
            pre_start + 1 + left_subtree_size,
            root_index + 1,
            in_end,
        );

        Some(Rc::new(RefCell::new(TreeNode {
            val: root_val,
            left,
            right,
        })))
    }

    let index_map: std::collections::HashMap<_, _> = inorder
        .iter()
        .enumerate()
        .map(|(i, &val)| (val, i))
        .collect();

    build(&preorder, &inorder, &index_map, 0, 0, inorder.len() - 1)
}
}