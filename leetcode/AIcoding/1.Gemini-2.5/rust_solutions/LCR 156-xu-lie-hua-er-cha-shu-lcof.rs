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

struct Codec {
}

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = Vec::new();
        self.preorder_serialize(root, &mut result);
        result.join(",")
    }

    fn preorder_serialize(&self, node: Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<String>) {
        if let Some(n) = node {
            let n_borrow = n.borrow();
            result.push(n_borrow.val.to_string());
            self.preorder_serialize(n_borrow.left.clone(), result);
            self.preorder_serialize(n_borrow.right.clone(), result);
        } else {
            result.push("#".to_string());
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let nodes: Vec<&str> = data.split(',').collect();
        let mut index = 0;
        self.preorder_deserialize_helper(&nodes, &mut index)
    }

    fn preorder_deserialize_helper(&self, nodes: &Vec<&str>, index: &mut usize) -> Option<Rc<RefCell<TreeNode>>> {
        if *index >= nodes.len() || nodes[*index] == "#" {
            *index += 1;
            return None;
        }

        let val = nodes[*index].parse::<i32>().unwrap();
        *index += 1;
        let node = Rc::new(RefCell::new(TreeNode::new(val)));
        node.borrow_mut().left = self.preorder_deserialize_helper(nodes, index);
        node.borrow_mut().right = self.preorder_deserialize_helper(nodes, index);
        Some(node)
    }
}