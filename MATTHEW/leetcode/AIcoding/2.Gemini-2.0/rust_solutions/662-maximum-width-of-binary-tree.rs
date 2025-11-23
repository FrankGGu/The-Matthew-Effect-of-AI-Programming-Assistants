use std::cell::RefCell;
use std::collections::VecDeque;
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

impl Solution {
    pub fn width_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut queue: VecDeque<(Rc<RefCell<TreeNode>>, i64)> = VecDeque::new();
        queue.push_back((root.unwrap(), 0));

        let mut max_width = 0;

        while !queue.is_empty() {
            let len = queue.len();
            let start = queue.front().unwrap().1;
            let end = queue.back().unwrap().1;

            max_width = max_width.max(end - start + 1);

            for _ in 0..len {
                if let Some((node, index)) = queue.pop_front() {
                    if let Some(left) = &node.borrow().left {
                        queue.push_back((Rc::clone(left), 2 * index));
                    }
                    if let Some(right) = &node.borrow().right {
                        queue.push_back((Rc::clone(right), 2 * index + 1));
                    }
                }
            }
        }

        max_width as i32
    }
}

struct Solution;