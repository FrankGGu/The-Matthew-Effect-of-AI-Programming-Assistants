use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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
      right: None
    }
  }
}

struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    queue: VecDeque<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut q = VecDeque::new();
        let mut bfs_q = VecDeque::new();

        if let Some(r) = &root {
            bfs_q.push_back(Rc::clone(r));
        }

        while let Some(node) = bfs_q.pop_front() {
            if node.borrow().left.is_none() || node.borrow().right.is_none() {
                q.push_back(Rc::clone(&node));
            }

            if let Some(left_child) = &node.borrow().left {
                bfs_q.push_back(Rc::clone(left_child));
            }
            if let Some(right_child) = &node.borrow().right {
                bfs_q.push_back(Rc::clone(right_child));
            }
        }

        CBTInserter {
            root,
            queue: q,
        }
    }

    fn insert(&mut self, val: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));

        let parent = self.queue.front().unwrap();
        let parent_val = parent.borrow().val;

        if parent.borrow().left.is_none() {
            parent.borrow_mut().left = Some(Rc::clone(&new_node));
        } else {
            parent.borrow_mut().right = Some(Rc::clone(&new_node));
            self.queue.pop_front();
        }

        self.queue.push_back(new_node);

        parent_val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.as_ref().map(Rc::clone)
    }
}