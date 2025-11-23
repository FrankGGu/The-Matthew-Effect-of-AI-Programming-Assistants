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

struct Solution;

impl Solution {
    pub fn flip_match_voyage(root: Option<Rc<RefCell<TreeNode>>>, voyage: Vec<i32>) -> Vec<i32> {
        let mut flips = Vec::new();
        let mut idx = 0;

        if Solution::dfs(root, &voyage, &mut idx, &mut flips) {
            flips
        } else {
            vec![-1]
        }
    }

    fn dfs(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        voyage: &[i32],
        idx: &mut usize,
        flips: &mut Vec<i32>,
    ) -> bool {
        if node_opt.is_none() {
            return true;
        }

        let node_rc = node_opt.unwrap();
        let node = node_rc.borrow();

        if *idx >= voyage.len() || node.val != voyage[*idx] {
            return false;
        }
        *idx += 1;

        let left_child_opt = node.left.clone();
        let right_child_opt = node.right.clone();

        let mut should_flip = false;
        if let Some(left_rc) = &left_child_opt {
            let left_val = left_rc.borrow().val;
            if *idx < voyage.len() && left_val != voyage[*idx] {
                if let Some(right_rc) = &right_child_opt {
                    let right_val = right_rc.borrow().val;
                    if *idx < voyage.len() && right_val == voyage[*idx] {
                        should_flip = true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
        }

        if should_flip {
            flips.push(node.val);
            if !Solution::dfs(right_child_opt, voyage, idx, flips) {
                return false;
            }
            if !Solution::dfs(left_child_opt, voyage, idx, flips) {
                return false;
            }
        } else {
            if !Solution::dfs(left_child_opt, voyage, idx, flips) {
                return false;
            }
            if !Solution::dfs(right_child_opt, voyage, idx, flips) {
                return false;
            }
        }

        true
    }
}