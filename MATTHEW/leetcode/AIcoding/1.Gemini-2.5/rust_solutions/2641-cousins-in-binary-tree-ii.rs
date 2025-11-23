use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{VecDeque, HashMap};

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
    pub fn replace_cousins(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let root_rc = root.as_ref().unwrap().clone();
        root_rc.borrow_mut().val = 0;

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root_rc);

        while !queue.is_empty() {
            let parents_in_current_level_queue_size = queue.len();

            let mut next_level_nodes: Vec<Rc<RefCell<TreeNode>>> = Vec::new();
            let mut next_level_total_sum = 0;
            let mut sibling_sum_map: HashMap<Rc<RefCell<TreeNode>>, i32> = HashMap::new();

            for _ in 0..parents_in_current_level_queue_size {
                let parent_rc = queue.pop_front().unwrap();
                let parent_ref = parent_rc.borrow();

                let mut current_parent_children: Vec<Rc<RefCell<TreeNode>>> = Vec::new();
                let mut current_parent_children_sum = 0;

                if let Some(left_child_rc) = &parent_ref.left {
                    current_parent_children.push(left_child_rc.clone());
                    current_parent_children_sum += left_child_rc.borrow().val;
                }
                if let Some(right_child_rc) = &parent_ref.right {
                    current_parent_children.push(right_child_rc.clone());
                    current_parent_children_sum += right_child_rc.borrow().val;
                }

                for child_rc in current_parent_children {
                    next_level_nodes.push(child_rc.clone());
                    next_level_total_sum += child_rc.borrow().val;
                    sibling_sum_map.insert(child_rc, current_parent_children_sum);
                }
            }

            if next_level_nodes.is_empty() {
                break;
            }

            for child_rc in &next_level_nodes {
                let mut child_ref = child_rc.borrow_mut();
                let sum_of_siblings_including_self = sibling_sum_map.get(child_rc).unwrap_or(&0);
                child_ref.val = next_level_total_sum - sum_of_siblings_including_self;
            }

            for child_rc in next_level_nodes {
                queue.push_back(child_rc);
            }
        }

        root
    }
}