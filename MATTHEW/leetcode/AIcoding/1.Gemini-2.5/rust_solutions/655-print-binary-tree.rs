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
      right: None
    }
  }
}

impl Solution {
    pub fn print_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<String>> {
        let height = Self::get_height(&root);
        let m = height + 1;
        let n = (1 << m) - 1;

        let mut result = vec![vec![String::from(""); n as usize]; m as usize];

        Self::place_node(root, &mut result, 0, 0, n - 1);

        result
    }

    fn get_height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            None => -1,
            Some(node_rc) => {
                let node_borrow = node_rc.borrow();
                1 + std::cmp::max(
                    Self::get_height(&node_borrow.left),
                    Self::get_height(&node_borrow.right),
                )
            }
        }
    }

    fn place_node(
        node: Option<Rc<RefCell<TreeNode>>>,
        result: &mut Vec<Vec<String>>,
        row: i32,
        left_bound: i32,
        right_bound: i32,
    ) {
        if let Some(node_rc) = node {
            let node_borrow = node_rc.borrow();
            let mid_col = (left_bound + right_bound) / 2;

            result[row as usize][mid_col as usize] = node_borrow.val.to_string();

            Self::place_node(
                node_borrow.left.clone(),
                result,
                row + 1,
                left_bound,
                mid_col - 1,
            );
            Self::place_node(
                node_borrow.right.clone(),
                result,
                row + 1,
                mid_col + 1,
                right_bound,
            );
        }
    }
}