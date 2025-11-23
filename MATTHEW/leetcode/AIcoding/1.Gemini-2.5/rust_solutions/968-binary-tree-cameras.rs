use std::rc::Rc;
use std::cell::RefCell;

enum NodeState {
    // The node is not covered and needs its parent to cover it.
    NeedsCamera,
    // The node has a camera.
    HasCamera,
    // The node is covered by one of its children or its parent, but does not have a camera itself.
    Covered,
}

struct Solution;

impl Solution {
    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut cameras_count = 0;
        let root_state = Self::dfs(&root, &mut cameras_count);

        // If the root itself needs to be covered after the DFS,
        // it means no child camera covered it, and it has no parent to cover it.
        // So, we must place a camera on the root.
        if let NodeState::NeedsCamera = root_state {
            cameras_count += 1;
        }

        cameras_count
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, cameras_count: &mut i32) -> NodeState {
        // Base case: A null node is considered covered.
        if node.is_none() {
            return NodeState::Covered;
        }

        let node_ref = node.as_ref().unwrap().borrow();

        let left_state = Self::dfs(&node_ref.left, cameras_count);
        let right_state = Self::dfs(&node_ref.right, cameras_count);

        // Rule 1: If any child needs a camera, the current node *must* place a camera.
        // This is the highest priority to ensure all nodes are covered.
        if let NodeState::NeedsCamera = left_state {
            *cameras_count += 1;
            return NodeState::HasCamera;
        }
        if let NodeState::NeedsCamera = right_state {
            *cameras_count += 1;
            return NodeState::HasCamera;
        }

        // Rule 2: If any child has a camera, the current node is covered by it.
        // It does not need a camera and does not need its parent to cover it.
        if let NodeState::HasCamera = left_state {
            return NodeState::Covered;
        }
        if let NodeState::HasCamera = right_state {
            return NodeState::Covered;
        }

        // Rule 3: If both children are covered (neither needs a camera, nor has one),
        // the current node is not covered by its children.
        // It needs its parent to cover it.
        NodeState::NeedsCamera
    }
}