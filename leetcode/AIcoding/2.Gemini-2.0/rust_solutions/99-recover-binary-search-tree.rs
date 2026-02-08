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

struct Solution {
    first: Option<Rc<RefCell<TreeNode>>>,
    second: Option<Rc<RefCell<TreeNode>>>,
    prev: Option<Rc<RefCell<TreeNode>>>,
}

impl Solution {
    fn new() -> Self {
        Solution {
            first: None,
            second: None,
            prev: None,
        }
    }

    fn recover_tree(&mut self, root: &mut Option<Rc<RefCell<TreeNode>>>) {
        self.inorder(root);

        if let (Some(first), Some(second)) = (&self.first, &self.second) {
            let first_val = first.borrow().val;
            let second_val = second.borrow().val;
            first.borrow_mut().val = second_val;
            second.borrow_mut().val = first_val;
        }
    }

    fn inorder(&mut self, root: &Option<Rc<RefCell<TreeNode>>>) {
        if let Some(node) = root {
            let left = node.borrow().left.clone();
            self.inorder(&left);

            if let Some(prev) = &self.prev {
                if prev.borrow().val > node.borrow().val {
                    if self.first.is_none() {
                        self.first = Some(prev.clone());
                    }
                    self.second = Some(node.clone());
                }
            }
            self.prev = Some(node.clone());

            let right = node.borrow().right.clone();
            self.inorder(&right);
        }
    }
}

impl Solution {
    pub fn recover_tree_main(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        let mut solution = Solution::new();
        solution.recover_tree(root);
    }
}