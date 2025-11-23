impl Solution {

use std::ptr::NonNull;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct Node {
    pub val: i32,
    pub prev: Option<NonNull<Node>>,
    pub next: Option<NonNull<Node>>,
    pub child: Option<NonNull<Node>>,
}

impl Node {
    #[inline]
    pub unsafe fn new(val: i32) -> Self {
        Node {
            val,
            prev: None,
            next: None,
            child: None,
        }
    }
}

pub fn flatten(mut head: Option<NonNull<Node>>) -> Option<NonNull<Node>> {
    let mut stack = Vec::new();
    let mut current = head;

    while let Some(node) = current {
        unsafe {
            let node_ptr = node.as_ptr();

            if let Some(child) = (*node_ptr).child {
                if let Some(next) = (*node_ptr).next {
                    stack.push(next);
                }
                (*node_ptr).next = Some(child);
                (*child.as_ptr()).prev = Some(node);
                (*node_ptr).child = None;
                current = Some(child);
            } else {
                if let Some(next) = (*node_ptr).next {
                    current = Some(next);
                } else if let Some(top) = stack.pop() {
                    (*top.as_ptr()).prev = Some(node);
                    (*node_ptr).next = Some(top);
                    current = Some(top);
                } else {
                    break;
                }
            }
        }
    }

    head
}
}