use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn good_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_val: i32) -> i32 {
            match node {
                Some(n) => {
                    let mut node_ref = n.borrow_mut();
                    let current_val = node_ref.val;
                    let mut count = 0;
                    if current_val >= max_val {
                        count += 1;
                    }
                    let new_max = std::cmp::max(max_val, current_val);
                    count += dfs(node_ref.left.clone(), new_max);
                    count += dfs(node_ref.right.clone(), new_max);
                    count
                }
                None => 0,
            }
        }

        dfs(root, i32::MIN)
    }
}

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

struct Solution;