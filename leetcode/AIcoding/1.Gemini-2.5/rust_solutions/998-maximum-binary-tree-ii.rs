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
    pub fn insert_into_max_tree(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        // If the current root is None, it means we've found the spot
        // to insert the new value. Create a new node and return it.
        if root.is_none() {
            return Some(Rc::new(RefCell::new(TreeNode::new(val))));
        }

        // We know root is Some, so unwrap it to access its value and children.
        let node_rc = root.as_ref().unwrap();
        let mut node_borrow = node_rc.borrow_mut();

        // Case 1: If 'val' is greater than the current node's value.
        // According to the rules of a Maximum Binary Tree (where 'val' is conceptually
        // appended to the array that formed the tree), if 'val' is the new maximum,
        // it becomes the new root. The entire old 'root' tree becomes its left child.
        // 'val' will not have a right child initially, as all elements of the old tree
        // are to its left in the conceptual array.
        if val > node_borrow.val {
            let new_node = Rc::new(RefCell::new(TreeNode {
                val,
                left: root, // The old root (and its subtree) becomes the left child
                right: None,
            }));
            return Some(new_node);
        } 
        // Case 2: If 'val' is less than the current node's value.
        // The current node remains the root. Since 'val' is conceptually appended
        // to the array, it must be located to the right of the current root in the array.
        // Therefore, we recursively insert 'val' into the right subtree.
        else {
            // We use .take() to temporarily remove the right child from the current node,
            // allowing us to pass it to the recursive call. The result of the recursive
            // call will then be assigned back to the right child.
            node_borrow.right = Self::insert_into_max_tree(node_borrow.right.take(), val);

            // Return a clone of the original root's Rc, as it remains the root of this subtree.
            Some(node_rc.clone())
        }
    }
}