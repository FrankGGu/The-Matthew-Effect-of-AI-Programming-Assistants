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
    pub fn flip_match_voyage(root: Option<Rc<RefCell<TreeNode>>>, voyage: Vec<i32>) -> Vec<i32> {
        let mut flipped = Vec::new();
        let mut i = 0;

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, voyage: &Vec<i32>, i: &mut usize, flipped: &mut Vec<i32>) -> bool {
            if node.is_none() {
                return true;
            }

            let node_val = node.as_ref().unwrap().borrow().val;
            if node_val != voyage[*i] {
                return false;
            }

            *i += 1;

            let left = node.as_ref().unwrap().borrow().left.clone();
            let right = node.as_ref().unwrap().borrow().right.clone();

            if let Some(left_node) = left.clone() {
                if let Some(right_node) = right.clone() {
                    if voyage.get(*i).is_some() && left_node.borrow().val != voyage[*i] {
                        flipped.push(node_val);

                        return dfs(right.clone(), voyage, i, flipped) && dfs(left.clone(), voyage, i, flipped);
                    } else {
                        return dfs(left.clone(), voyage, i, flipped) && dfs(right.clone(), voyage, i, flipped);
                    }
                } else {
                    return dfs(left.clone(), voyage, i, flipped);
                }
            } else if let Some(right_node) = right.clone() {
                 return dfs(right.clone(), voyage, i, flipped);
            }

            true
        }

        if dfs(root, &voyage, &mut i, &mut flipped) {
            flipped
        } else {
            vec![-1]
        }
    }
}

struct Solution;