use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn balance_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes = Vec::new();
        Self::inorder_traversal(root, &mut nodes);
        Self::build_balanced_bst(&nodes, 0, nodes.len() as i32 - 1)
    }

    fn inorder_traversal(root: Option<Rc<RefCell<TreeNode>>>, nodes: &mut Vec<i32>) {
        if let Some(node) = root {
            let node = node.borrow();
            Self::inorder_traversal(node.left.clone(), nodes);
            nodes.push(node.val);
            Self::inorder_traversal(node.right.clone(), nodes);
        }
    }

    fn build_balanced_bst(nodes: &[i32], start: i32, end: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if start > end {
            return None;
        }
        let mid = start + (end - start) / 2;
        let mut node = TreeNode::new(nodes[mid as usize]);
        node.left = Self::build_balanced_bst(nodes, start, mid - 1);
        node.right = Self::build_balanced_bst(nodes, mid + 1, end);
        Some(Rc::new(RefCell::new(node)))
    }
}