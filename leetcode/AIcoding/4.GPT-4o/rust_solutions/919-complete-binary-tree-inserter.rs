use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

pub struct CBTInserter {
    root: Option<Box<TreeNode>>,
    deque: VecDeque<*mut TreeNode>,
}

impl CBTInserter {
    pub fn new(root: Option<Box<TreeNode>>) -> Self {
        let mut deque = VecDeque::new();
        let mut queue = VecDeque::new();

        if let Some(ref root) = root {
            queue.push_back(root.as_ref() as *const _ as *mut _);
        }

        while let Some(node) = queue.pop_front() {
            if node.is_null() {
                continue;
            }
            deque.push_back(node);
            unsafe {
                queue.push_back((*node).left.as_ref().map_or(std::ptr::null_mut(), |l| l.as_ref() as *const _ as *mut _)));
                queue.push_back((*node).right.as_ref().map_or(std::ptr::null_mut(), |r| r.as_ref() as *const _ as *mut _)));
            }
        }

        CBTInserter { root, deque }
    }

    pub fn insert(&mut self, val: i32) -> i32 {
        let new_node = Box::new(TreeNode::new(val));
        let new_node_ptr = Box::into_raw(new_node);
        let parent_ptr = self.deque.front().unwrap();

        unsafe {
            if (*parent_ptr).left.is_none() {
                (*parent_ptr).left = Some(Box::from_raw(new_node_ptr));
            } else {
                (*parent_ptr).right = Some(Box::from_raw(new_node_ptr));
                self.deque.pop_front();
            }
        }

        self.deque.push_back(new_node_ptr);
        unsafe { (*parent_ptr).val }
    }

    pub fn get_root(&self) -> Option<Box<TreeNode>> {
        self.root.clone()
    }
}