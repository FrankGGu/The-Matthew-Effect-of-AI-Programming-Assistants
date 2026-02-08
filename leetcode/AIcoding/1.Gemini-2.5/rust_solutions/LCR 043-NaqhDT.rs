use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    q: VecDeque<Rc<RefCell<TreeNode>>>, // Stores nodes that have less than two children, in level order.
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut inserter = CBTInserter {
            root: root.clone(),
            q: VecDeque::new(),
        };

        if let Some(r) = root {
            let mut temp_q = VecDeque::new();
            temp_q.push_back(r);

            while let Some(curr) = temp_q.pop_front() {
                // If curr has less than two children, it's a potential parent for future insertions.
                if curr.borrow().left.is_none() || curr.borrow().right.is_none() {
                    inserter.q.push_back(curr.clone());
                }

                // Add children to temp_q for level-order traversal
                if let Some(left_child) = curr.borrow().left.clone() {
                    temp_q.push_back(left_child);
                }
                if let Some(right_child) = curr.borrow().right.clone() {
                    temp_q.push_back(right_child);
                }
            }
        }

        inserter
    }

    fn insert(&mut self, val: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));

        // According to the problem statement, `new` initializes with the root of a complete binary tree,
        // so `self.root` will always be `Some` and `self.q` will not be empty here.
        let parent = self.q.front().unwrap().clone(); // Get the next available parent
        let parent_val = parent.borrow().val;

        if parent.borrow().left.is_none() {
            parent.borrow_mut().left = Some(new_node.clone());
        } else {
            // At this point, parent.borrow().right.is_none() must be true
            parent.borrow_mut().right = Some(new_node.clone());
            self.q.pop_front(); // Parent is now full, remove it from the queue
        }

        self.q.push_back(new_node); // New node is now a potential parent
        parent_val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.clone()
    }
}