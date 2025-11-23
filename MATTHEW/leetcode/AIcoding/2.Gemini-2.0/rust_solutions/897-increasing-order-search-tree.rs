#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
  pub val: i32,
  pub left: Option<std::rc::Rc<std::cell::RefCell<TreeNode>>>,
  pub right: Option<std::rc::Rc<std::cell::RefCell<TreeNode>>>,
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
    pub fn increasing_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes = Vec::new();
        fn inorder(node: &Option<Rc<RefCell<TreeNode>>>, nodes: &mut Vec<i32>) {
            if let Some(n) = node {
                inorder(&n.borrow().left, nodes);
                nodes.push(n.borrow().val);
                inorder(&n.borrow().right, nodes);
            }
        }
        inorder(&root, &mut nodes);
        let mut dummy = TreeNode::new(0);
        let mut current = &mut dummy;
        for val in nodes {
            current.right = Some(Rc::new(RefCell::new(TreeNode::new(val))));
            current = current.right.as_mut().unwrap().borrow_mut().as_mut();
        }
        dummy.right
    }
}