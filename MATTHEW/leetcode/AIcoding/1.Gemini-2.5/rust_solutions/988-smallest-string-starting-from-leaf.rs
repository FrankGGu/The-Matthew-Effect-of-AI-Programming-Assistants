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
    pub fn smallest_from_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut smallest_string = String::new();
        let mut current_path_chars: Vec<char> = Vec::new();

        Self::dfs(root, &mut current_path_chars, &mut smallest_string);

        smallest_string
    }

    fn dfs(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        current_path_chars: &mut Vec<char>,
        smallest_string: &mut String,
    ) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();

            let char_val = (b'a' + node.val as u8) as char;
            current_path_chars.push(char_val);

            if node.left.is_none() && node.right.is_none() {
                let path_str: String = current_path_chars.iter().rev().collect();

                if smallest_string.is_empty() || path_str < *smallest_string {
                    *smallest_string = path_str;
                }
            } else {
                Self::dfs(node.left.clone(), current_path_chars, smallest_string);
                Self::dfs(node.right.clone(), current_path_chars, smallest_string);
            }

            current_path_chars.pop();
        }
    }
}