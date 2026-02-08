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

struct CBTInserter {
    root: Rc<RefCell<TreeNode>>,
    nodes: Vec<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let root = root.unwrap();
        let mut nodes = Vec::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root.clone());

        while !queue.is_empty() {
            let node = queue.pop_front().unwrap();
            nodes.push(node.clone());

            let left = node.borrow().left.clone();
            if let Some(left) = left {
                queue.push_back(left.clone());
            }

            let right = node.borrow().right.clone();
            if let Some(right) = right {
                queue.push_back(right.clone());
            }
        }

        CBTInserter { root, nodes }
    }

    fn insert(&mut self, val: i32) -> i32 {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));
        self.nodes.push(new_node.clone());

        let parent_index = (self.nodes.len() - 2) / 2;
        let parent = self.nodes[parent_index].clone();

        if parent.borrow().left.is_none() {
            parent.borrow_mut().left = Some(new_node.clone());
        } else {
            parent.borrow_mut().right = Some(new_node.clone());
        }

        parent.borrow().val
    }

    fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        Some(self.root.clone())
    }
}