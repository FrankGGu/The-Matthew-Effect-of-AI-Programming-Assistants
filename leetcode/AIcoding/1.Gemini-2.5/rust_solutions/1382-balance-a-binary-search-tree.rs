use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn balance_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut values = Vec::new();
        Self::inorder_traversal(root, &mut values);
        Self::build_balanced_bst(&values)
    }

    fn inorder_traversal(node: Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
        if let Some(n) = node {
            Self::inorder_traversal(n.borrow().left.clone(), values);
            values.push(n.borrow().val);
            Self::inorder_traversal(n.borrow().right.clone(), values);
        }
    }

    fn build_balanced_bst(values: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if values.is_empty() {
            return None;
        }

        let mid = values.len() / 2;
        let root_val = values[mid];

        let mut root_node = TreeNode::new(root_val);
        root_node.left = Self::build_balanced_bst(&values[0..mid]);
        root_node.right = Self::build_balanced_bst(&values[mid + 1..]);

        Some(Rc::new(RefCell::new(root_node)))
    }
}