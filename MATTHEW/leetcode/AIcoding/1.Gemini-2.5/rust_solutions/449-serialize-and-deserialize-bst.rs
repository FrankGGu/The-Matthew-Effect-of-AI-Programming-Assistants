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

struct Codec;

impl Codec {
    fn new() -> Self {
        Codec
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = Vec::new();
        self._serialize_helper(root, &mut result);
        result.join(",")
    }

    fn _serialize_helper(&self, node: Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<String>) {
        if let Some(n) = node {
            result.push(n.borrow().val.to_string());
            self._serialize_helper(n.borrow().left.clone(), result);
            self._serialize_helper(n.borrow().right.clone(), result);
        } else {
            result.push("#".to_string());
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes_str: Vec<&str> = data.split(',').collect();
        let mut index = 0;
        self._deserialize_helper(&nodes_str, &mut index)
    }

    fn _deserialize_helper(&self, nodes_str: &Vec<&str>, index: &mut usize) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= nodes_str.len() {
            return None;
        }

        let current_val = nodes_str[*index];
        *index += 1;

        if current_val == "#" {
            return None;
        }

        let val = current_val.parse::<i32>().unwrap();
        let node = Rc::new(RefCell::new(TreeNode::new(val)));

        node.borrow_mut().left = self._deserialize_helper(nodes_str, index);
        node.borrow_mut().right = self._deserialize_helper(nodes_str, index);

        Some(node)
    }
}