use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

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

struct FindElements {
    recovered_values: HashSet<i32>,
}

impl FindElements {

    fn recover_and_store(node: Option<Rc<RefCell<TreeNode>>>, current_val: i32, values: &mut HashSet<i32>) {
        if let Some(n_rc) = node {
            values.insert(current_val);
            let n = n_rc.borrow();

            Self::recover_and_store(n.left.clone(), 2 * current_val + 1, values);
            Self::recover_and_store(n.right.clone(), 2 * current_val + 2, values);
        }
    }

    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut recovered_values = HashSet::new();
        Self::recover_and_store(root, 0, &mut recovered_values);
        FindElements { recovered_values }
    }

    fn find(&self, target: i32) -> bool {
        self.recovered_values.contains(&target)
    }
}