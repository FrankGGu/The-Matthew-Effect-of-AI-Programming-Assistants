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
use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sum_numbers(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_number: i32) -> i32 {
            match node {
                Some(node_ref) => {
                    let node = node_ref.borrow();
                    let new_number = current_number * 10 + node.val;

                    if node.left.is_none() && node.right.is_none() {
                        return new_number;
                    }

                    let mut sum = 0;
                    if node.left.is_some() {
                        sum += dfs(node.left.clone(), new_number);
                    }
                    if node.right.is_some() {
                        sum += dfs(node.right.clone(), new_number);
                    }

                    sum
                }
                None => 0,
            }
        }

        dfs(root, 0)
    }
}