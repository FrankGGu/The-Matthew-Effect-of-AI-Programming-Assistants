use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{BTreeMap, VecDeque};

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
    pub fn vertical_order_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut map: BTreeMap<i32, Vec<(i32, i32)>> = BTreeMap::new(); // col -> Vec<(row, val)>
        let mut queue: VecDeque<(Rc<RefCell<TreeNode>>, i32, i32)> = VecDeque::new(); // (node, col, row)

        if let Some(node) = root {
            queue.push_back((node, 0, 0));
        }

        while let Some((node_rc, col, row)) = queue.pop_front() {
            let node = node_rc.borrow();
            map.entry(col).or_default().push((row, node.val));

            if let Some(left_child) = node.left.clone() {
                queue.push_back((left_child, col - 1, row + 1));
            }
            if let Some(right_child) = node.right.clone() {
                queue.push_back((right_child, col + 1, row + 1));
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        for (_, mut nodes_in_col) in map {
            nodes_in_col.sort_unstable();

            let current_col_vals: Vec<i32> = nodes_in_col.into_iter().map(|(_, val)| val).collect();
            result.push(current_col_vals);
        }

        result
    }
}