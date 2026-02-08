use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug)]
struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    queue: Vec<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut queue = Vec::new();
        if let Some(r) = &root {
            queue.push(r.clone());
            let mut i = 0;
            while i < queue.len() {
                let node = queue[i].borrow();
                if let Some(ref left) = node.left {
                    queue.push(left.clone());
                }
                if let Some(ref right) = node.right {
                    queue.push(right.clone());
                }
                i += 1;
            }
        }
        CBTInserter { root, queue }
    }

    fn insert(&mut self, v: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(v)));
        let parent = self.queue[0].clone();
        let mut parent_borrow = parent.borrow_mut();
        if parent_borrow.left.is_none() {
            parent_borrow.left = Some(new_node.clone());
        } else {
            parent_borrow.right = Some(new_node.clone());
            self.queue.remove(0);
        }
        self.queue.push(new_node);
        parent_borrow.val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.clone()
    }
}