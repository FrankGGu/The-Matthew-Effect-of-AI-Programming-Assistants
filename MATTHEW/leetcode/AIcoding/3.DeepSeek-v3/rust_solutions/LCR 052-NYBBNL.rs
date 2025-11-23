use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn increasing_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut dummy = Rc::new(RefCell::new(TreeNode::new(0)));
        let mut current = Rc::clone(&dummy);
        let mut stack = Vec::new();
        let mut node = root;

        while node.is_some() || !stack.is_empty() {
            while let Some(n) = node {
                stack.push(Rc::clone(&n));
                node = n.borrow().left.clone();
            }
            if let Some(n) = stack.pop() {
                node = n.borrow().right.clone();
                current.borrow_mut().right = Some(Rc::clone(&n));
                current = n;
                current.borrow_mut().left = None;
            }
        }

        let result = dummy.borrow().right.clone();
        result
    }
}