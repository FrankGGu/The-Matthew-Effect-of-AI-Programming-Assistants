use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    fn get_height(node_opt: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut height = -1; // Represents height as number of edges. -1 for None, 0 for a leaf node.
        let mut current_node_ptr = node_opt.as_ref();

        while let Some(rc_node) = current_node_ptr {
            height += 1;
            current_node_ptr = rc_node.borrow().left.as_ref();
        }
        height
    }

    pub fn count_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let borrowed_root = root.as_ref().unwrap().borrow();

        let left_height = Self::get_height(&borrowed_root.left);
        let right_height = Self::get_height(&borrowed_root.right);

        if left_height == right_height {
            // The left subtree is a perfect binary tree of height `left_height`.
            // The total nodes in this perfect subtree is `2^(left_height + 1) - 1`.
            // Total nodes = (nodes in left perfect subtree) + (root node) + (nodes in right subtree)
            //             = ((1 << (left_height + 1)) - 1) + 1 + count_nodes(right_subtree)
            //             = (1 << (left_height + 1)) + count_nodes(right_subtree)
            (1 << (left_height + 1)) + Self::count_nodes(borrowed_root.right.clone())
        } else {
            // For a complete binary tree, if left_height != right_height,
            // it must be that left_height = right_height + 1.
            // This means the right subtree is a perfect binary tree of height `right_height`.
            // The total nodes in this perfect subtree is `2^(right_height + 1) - 1`.
            // Total nodes = (nodes in right perfect subtree) + (root node) + (nodes in left subtree)
            //             = ((1 << (right_height + 1)) - 1) + 1 + count_nodes(left_subtree)
            //             = (1 << (right_height + 1)) + count_nodes(left_subtree)
            (1 << (right_height + 1)) + Self::count_nodes(borrowed_root.left.clone())
        }
    }
}