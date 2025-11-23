impl Solution {

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

type Node = Rc<RefCell<TreeNode>>;

pub fn kth_largest_perfect_subtree(root: Option<Node>, k: i32) -> i32 {
    use std::collections::BinaryHeap;

    fn is_perfect(node: &Node) -> (bool, usize) {
        let left = node.borrow().left.as_ref();
        let right = node.borrow().right.as_ref();

        if left.is_none() && right.is_none() {
            return (true, 1);
        }

        if left.is_none() || right.is_none() {
            return (false, 0);
        }

        let (left_perfect, left_size) = is_perfect(left.unwrap());
        let (right_perfect, right_size) = is_perfect(right.unwrap());

        if left_perfect && right_perfect && left_size == right_size {
            (true, left_size + right_size + 1)
        } else {
            (false, 0)
        }
    }

    let mut heap = BinaryHeap::new();
    let mut stack = vec![root];

    while let Some(node) = stack.pop() {
        if let Some(n) = node {
            let (is_perfect, size) = is_perfect(&n);
            if is_perfect {
                heap.push(size);
            }
            stack.push(n.borrow().left.clone());
            stack.push(n.borrow().right.clone());
        }
    }

    let mut result = -1;
    for _ in 0..k {
        if let Some(size) = heap.pop() {
            result = size as i32;
        } else {
            break;
        }
    }

    result
}
}