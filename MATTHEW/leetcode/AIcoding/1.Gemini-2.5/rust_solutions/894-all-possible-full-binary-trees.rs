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
  pub fn new(val: i332) -> Self {
    TreeNode {
      val,
      left: None,
      right: None
    }
  }
}

impl Solution {
    pub fn all_possible_fbt(n: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut memo: HashMap<i32, Vec<Option<Rc<RefCell<TreeNode>>>>> = HashMap::new();
        Self::all_possible_fbt_memo(n, &mut memo)
    }

    fn all_possible_fbt_memo(n: i32, memo: &mut HashMap<i32, Vec<Option<Rc<RefCell<TreeNode>>>>>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        if n % 2 == 0 {
            return vec![];
        }

        if let Some(cached_result) = memo.get(&n) {
            return cached_result.clone();
        }

        let mut result = Vec::new();

        if n == 1 {
            result.push(Some(Rc::new(RefCell::new(TreeNode::new(0)))));
        } else {
            for i in (1..n).step_by(2) {
                let j = n - 1 - i;

                let left_subtrees = Self::all_possible_fbt_memo(i, memo);
                let right_subtrees = Self::all_possible_fbt_memo(j, memo);

                for left_tree in left_subtrees.iter() {
                    for right_tree in right_subtrees.iter() {
                        let mut root = TreeNode::new(0);
                        root.left = left_tree.clone();
                        root.right = right_tree.clone();
                        result.push(Some(Rc::new(RefCell::new(root))));
                    }
                }
            }
        }

        memo.insert(n, result.clone());
        result
    }
}