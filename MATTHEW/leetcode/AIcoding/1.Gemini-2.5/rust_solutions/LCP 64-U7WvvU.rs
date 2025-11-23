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

struct Solution {
    cameras: i32,
}

impl Solution {
    // State definitions for a node after processing its children:
    // NOT_MONITORED: The node is not monitored by its children, and does not have a camera itself.
    //                Its parent *must* place a camera.
    const NOT_MONITORED: i32 = 0;

    // MONITORED: The node is monitored by one of its children (which has a camera),
    //            or it is a null node (considered trivially monitored).
    //            Its parent *does not* need to place a camera for this node.
    const MONITORED: i32 = 1;     

    // HAS_CAMERA: The node has a camera. It monitors itself, its parent, and its children.
    const HAS_CAMERA: i32 = 2;    

    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut sol = Solution { cameras: 0 };
        let root_state = sol.dfs(root);

        // If the root node itself is not monitored by its children and doesn't have a camera,
        // we must place a camera at the root.
        if root_state == Self::NOT_MONITORED {
            sol.cameras += 1;
        }

        sol.cameras
    }

    // Performs a post-order traversal to determine the state of each node
    // and count the minimum cameras needed.
    fn dfs(&mut self, node: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if node.is_none() {
            // Null nodes are considered monitored and do not require a camera.
            return Self::MONITORED;
        }

        let node_ref = node.unwrap();
        let node_borrow = node_ref.borrow();

        // Recursively get the states of the left and right children.
        let left_state = self.dfs(node_borrow.left.clone());
        let right_state = self.dfs(node_borrow.right.clone());

        // Decision logic based on children's states:

        // Case 1: If any child is NOT_MONITORED, the current node *must* place a camera
        // to cover that child (and itself, and its parent).
        if left_state == Self::NOT_MONITORED || right_state == Self::NOT_MONITORED {
            self.cameras += 1;
            return Self::HAS_CAMERA;
        }

        // Case 2: If any child has a camera (HAS_CAMERA), the current node is monitored by that child.
        // It does not need to place a camera, nor does its parent need to place one for it.
        if left_state == Self::HAS_CAMERA || right_state == Self::HAS_CAMERA {
            return Self::MONITORED;
        }

        // Case 3: Both children are MONITORED (but don't have cameras themselves,
        // and didn't require the current node to place one).
        // In this scenario, the current node is not monitored by its children and doesn't have a camera.
        // Therefore, it is NOT_MONITORED and needs its parent to monitor it.
        Self::NOT_MONITORED
    }
}