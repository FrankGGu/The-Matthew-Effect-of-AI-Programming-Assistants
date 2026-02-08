use std::rc::Rc;
use std::cell::RefCell;

struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    queue: std::collections::VecDeque<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut queue = std::collections::VecDeque::new();
        if let Some(node) = root.clone() {
            queue.push_back(node);
            while let Some(front) = queue.front() {
                let front = front.borrow();
                if front.left.is_none() || front.right.is_none() {
                    break;
                }
                let front = queue.pop_front().unwrap();
                let mut front = front.borrow_mut();
                queue.push_back(front.left.as_ref().unwrap().clone());
                queue.push_back(front.right.as_ref().unwrap().clone());
            }
        }
        CBTInserter { root, queue }
    }

    fn insert(&mut self, v: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(v)));
        let parent = self.queue.front().unwrap().clone();
        let mut parent = parent.borrow_mut();
        let val = parent.val;
        if parent.left.is_none() {
            parent.left = Some(new_node);
        } else {
            parent.right = Some(new_node);
            self.queue.pop_front();
        }
        self.queue.push_back(new_node);
        val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.clone()
    }
}

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