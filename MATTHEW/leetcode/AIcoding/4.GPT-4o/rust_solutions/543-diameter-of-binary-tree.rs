use std::rc::Rc;
use std::cell::RefCell;

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

pub struct Solution {
    diameter: i32,
}

impl Solution {
    pub fn diameter_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut solution = Solution { diameter: 0 };
        solution.depth(&root);
        solution.diameter
    }

    fn depth(&mut self, node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(n) = node {
            let left_depth = self.depth(&n.borrow().left);
            let right_depth = self.depth(&n.borrow().right);
            self.diameter = self.diameter.max(left_depth + right_depth);
            return 1 + left_depth.max(right_depth);
        }
        0
    }
}