use std::cell::RefCell;
use std::rc::Rc;
use std::vec::IntoIter;

struct BSTIterator {
    iter: IntoIter<i32>,
}

impl BSTIterator {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut values = Vec::new();
        Self::in_order_traversal(root, &mut values);
        BSTIterator {
            iter: values.into_iter(),
        }
    }

    fn in_order_traversal(node: Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            Self::in_order_traversal(n.left.clone(), values);
            values.push(n.val);
            Self::in_order_traversal(n.right.clone(), values);
        }
    }

    fn next(&mut self) -> i32 {
        self.iter.next().unwrap()
    }

    fn has_next(&self) -> bool {
        self.iter.len() > 0
    }
}

struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}