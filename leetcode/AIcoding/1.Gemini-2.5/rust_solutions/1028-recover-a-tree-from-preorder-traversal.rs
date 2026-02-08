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
    pub fn recover_from_preorder(traversal: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut stack: Vec<(Rc<RefCell<TreeNode>>, i32)> = Vec::new();
        let chars: Vec<char> = traversal.chars().collect();
        let mut i = 0;

        while i < chars.len() {
            let mut depth = 0;
            if i > 0 || !stack.is_empty() {
                while i < chars.len() && chars[i] == '-' {
                    depth += 1;
                    i += 1;
                }
            }

            let mut val_str = String::new();
            while i < chars.len() && chars[i].is_digit(10) {
                val_str.push(chars[i]);
                i += 1;
            }
            let val = val_str.parse::<i32>().unwrap();

            let new_node = Rc::new(RefCell::new(TreeNode::new(val)));

            if stack.is_empty() {
                stack.push((Rc::clone(&new_node), depth));
            } else {
                while let Some((_, top_depth)) = stack.last() {
                    if *top_depth >= depth {
                        stack.pop();
                    } else {
                        break;
                    }
                }

                if let Some((parent_node, _)) = stack.last() {
                    let mut parent_ref = parent_node.borrow_mut();
                    if parent_ref.left.is_none() {
                        parent_ref.left = Some(Rc::clone(&new_node));
                    } else {
                        parent_ref.right = Some(Rc::clone(&new_node));
                    }
                }
                stack.push((Rc::clone(&new_node), depth));
            }
        }

        stack.first().map(|(node, _)| Rc::clone(node))
    }
}