use std::collections::HashMap;
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
    pub fn find_duplicate_subtrees(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut counts: HashMap<String, i32> = HashMap::new();
        let mut duplicates: Vec<Option<Rc<RefCell<TreeNode>>>> = Vec::new();

        Self::traverse(&root, &mut counts, &mut duplicates);

        duplicates
    }

    fn traverse(
        node_option: &Option<Rc<RefCell<TreeNode>>>,
        counts: &mut HashMap<String, i32>,
        duplicates: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
    ) -> String {
        if let Some(node_rc) = node_option {
            let node = node_rc.borrow();
            let left_repr = Self::traverse(&node.left, counts, duplicates);
            let right_repr = Self::traverse(&node.right, counts, duplicates);

            let current_repr = format!("{},{},{}", node.val, left_repr, right_repr);

            *counts.entry(current_repr.clone()).or_insert(0) += 1;

            if *counts.get(&current_repr).unwrap() == 2 {
                duplicates.push(Some(Rc::clone(node_rc)));
            }

            current_repr
        } else {
            "#".to_string()
        }
    }
}