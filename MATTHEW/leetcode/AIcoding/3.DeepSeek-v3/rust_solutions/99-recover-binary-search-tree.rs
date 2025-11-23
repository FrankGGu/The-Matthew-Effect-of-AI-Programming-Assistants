use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn recover_tree(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        let mut stack = Vec::new();
        let mut curr = root.clone();
        let mut prev: Option<Rc<RefCell<TreeNode>>> = None;
        let mut first: Option<Rc<RefCell<TreeNode>>> = None;
        let mut second: Option<Rc<RefCell<TreeNode>>> = None;

        while !stack.is_empty() || curr.is_some() {
            while let Some(node) = curr {
                stack.push(node.clone());
                curr = node.borrow().left.clone();
            }
            curr = stack.pop();
            if let Some(node) = curr {
                if let Some(prev_node) = prev {
                    if prev_node.borrow().val > node.borrow().val {
                        if first.is_none() {
                            first = Some(prev_node.clone());
                        }
                        second = Some(node.clone());
                    }
                }
                prev = Some(node.clone());
                curr = node.borrow().right.clone();
            }
        }

        if let (Some(first_node), Some(second_node)) = (first, second) {
            let temp = first_node.borrow().val;
            first_node.borrow_mut().val = second_node.borrow().val;
            second_node.borrow_mut().val = temp;
        }
    }
}