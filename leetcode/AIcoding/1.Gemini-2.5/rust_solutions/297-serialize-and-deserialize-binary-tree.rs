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

struct Codec {}

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = Vec::new();
        Self::dfs_serialize(root, &mut result);
        result.join(",")
    }

    fn dfs_serialize(node_opt: Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<String>) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            result.push(node.val.to_string());
            Self::dfs_serialize(node.left.clone(), result);
            Self::dfs_serialize(node.right.clone(), result);
        } else {
            result.push("N".to_string());
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes_iter = data.split(',').into_iter();
        Self::dfs_deserialize(&mut nodes_iter)
    }

    fn dfs_deserialize(nodes_iter: &mut impl Iterator<Item = &str>) -> Option<Rc<RefCell<TreeNode>>> {
        let val_str = nodes_iter.next()?;

        if val_str == "N" {
            None
        } else {
            let val = val_str.parse::<i32>().unwrap();
            let node = Rc::new(RefCell::new(TreeNode::new(val)));
            node.borrow_mut().left = Self::dfs_deserialize(nodes_iter);
            node.borrow_mut().right = Self::dfs_deserialize(nodes_iter);
            Some(node)
        }
    }
}