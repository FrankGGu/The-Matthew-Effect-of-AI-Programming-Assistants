use std::cell::RefCell;
use std::rc::Rc;
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
    root: Rc<RefCell<TreeNode>>,
    queue: VecDeque<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {

    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let root = root.unwrap();
        let mut queue = VecDeque::new();
        let mut q = VecDeque::new();
        q.push_back(root.clone());

        while !q.is_empty() {
            let node = q.pop_front().unwrap();
            if node.borrow().left.is_none() || node.borrow().right.is_none() {
                queue.push_back(node.clone());
            }
            if let Some(left) = &node.borrow().left {
                q.push_back(left.clone());
            }
            if let Some(right) = &node.borrow().right {
                q.push_back(right.clone());
            }
        }

        CBTInserter {
            root,
            queue,
        }
    }

    fn insert(&mut self, val: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));
        let parent = self.queue.front().unwrap().clone();
        let mut parent_borrowed = parent.borrow_mut();

        if parent_borrowed.left.is_none() {
            parent_borrowed.left = Some(new_node.clone());
        } else {
            parent_borrowed.right = Some(new_node.clone());
            self.queue.pop_front();
        }

        self.queue.push_back(new_node);
        parent_borrowed.val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        Some(self.root.clone())
    }
}