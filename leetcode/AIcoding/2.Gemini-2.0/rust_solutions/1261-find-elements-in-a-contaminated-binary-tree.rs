use std::cell::RefCell;
use std::rc::Rc;

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
            right: None,
        }
    }
}

struct FindElements {
    root: Option<Rc<RefCell<TreeNode>>>,
}

impl FindElements {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        if let Some(r) = &root {
            r.borrow_mut().val = 0;
            Self::recover(r.clone());
        }
        FindElements { root }
    }

    fn recover(node: Rc<RefCell<TreeNode>>) {
        let left = node.borrow().left.clone();
        let right = node.borrow().right.clone();
        let val = node.borrow().val;

        if let Some(l) = left {
            l.borrow_mut().val = 2 * val + 1;
            Self::recover(l);
        }

        if let Some(r) = right {
            r.borrow_mut().val = 2 * val + 2;
            Self::recover(r);
        }
    }

    fn find(&self, target: i32) -> bool {
        Self::search(&self.root, target)
    }

    fn search(node: &Option<Rc<RefCell<TreeNode>>>, target: i32) -> bool {
        if let Some(n) = node {
            if n.borrow().val == target {
                return true;
            }
            let left = n.borrow().left.clone();
            let right = n.borrow().right.clone();
            return Self::search(&left, target) || Self::search(&right, target);
        }
        false
    }
}