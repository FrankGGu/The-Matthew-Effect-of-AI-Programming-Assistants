use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct BSTIterator {
    stack: VecDeque<Rc<RefCell<TreeNode>>>,
}

impl BSTIterator {
    pub fn new(root: Option<Box<TreeNode>>) -> Self {
        let mut stack = VecDeque::new();
        Self::push_left(&mut stack, root);
        BSTIterator { stack }
    }

    fn push_left(stack: &mut VecDeque<Rc<RefCell<TreeNode>>>, node: Option<Box<TreeNode>>) {
        let mut current = node;
        while let Some(node) = current {
            stack.push_back(Rc::new(RefCell::new(*node)));
            current = node.left;
        }
    }

    pub fn next(&mut self) -> i32 {
        let node = self.stack.pop_back().unwrap();
        let val = node.borrow().val;
        Self::push_left(&mut self.stack, node.borrow().right.clone());
        val
    }

    pub fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}