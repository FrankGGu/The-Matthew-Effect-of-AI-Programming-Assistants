use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

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
      right: None
    }
  }
}

impl Solution {
    pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        let n = preorder.len();
        if n == 0 {
            return None;
        }

        let mut inorder_map: HashMap<i32, usize> = HashMap::new();
        for (i, &val) in inorder.iter().enumerate() {
            inorder_map.insert(val, i);
        }

        Self::build_tree_recursive(
            &preorder, 0, n - 1,
            &inorder, 0, n - 1,
            &inorder_map
        )
    }

    fn build_tree_recursive(
        preorder: &[i32], pre_start: usize, pre_end: usize,
        inorder: &[i32], in_start: usize, in_end: usize,
        inorder_map: &HashMap<i32, usize>
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if pre_start > pre_end || in_start > in_end {
            return None;
        }

        let root_val = preorder[pre_start];
        let mut root = TreeNode::new(root_val);

        let in_root_idx = *inorder_map.get(&root_val).unwrap();

        let left_subtree_size = in_root_idx - in_start;

        root.left = Self::build_tree_recursive(
            preorder, pre_start + 1, pre_start + left_subtree_size,
            inorder, in_start, in_root_idx - 1,
            inorder_map
        );

        root.right = Self::build_tree_recursive(
            preorder, pre_start + left_subtree_size + 1, pre_end,
            inorder, in_root_idx + 1, in_end,
            inorder_map
        );

        Some(Rc::new(RefCell::new(root)))
    }
}