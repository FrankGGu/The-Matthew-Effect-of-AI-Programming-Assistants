use std::cell::RefCell;
use std::cmp::Ordering;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn balance_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    fn inorder_traversal(node: &Option<Rc<RefCell<TreeNode>>>, nodes: &mut Vec<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            inorder_traversal(&n.left, nodes);
            nodes.push(n.val);
            inorder_traversal(&n.right, nodes);
        }
    }

    fn build_balanced_bst(nodes: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nodes.is_empty() {
            return None;
        }
        let mid = nodes.len() / 2;
        let mut root = Rc::new(RefCell::new(TreeNode::new(nodes[mid])));
        let left = build_balanced_bst(&nodes[..mid]);
        let right = build_balanced_bst(&nodes[mid + 1..]);
        root.borrow_mut().left = left;
        root.borrow_mut().right = right;
        Some(root)
    }

    let mut nodes = Vec::new();
    inorder_traversal(&root, &mut nodes);
    build_balanced_bst(&nodes)
}