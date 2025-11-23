impl Solution {

use std::ptr::NonNull;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<NonNull<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        Self { next: None, val }
    }
}

pub fn odd_even_list(head: Option<NonNull<ListNode>>) -> Option<NonNull<ListNode>> {
    let mut odd = head;
    let mut even = head.and_then(|node| unsafe { (*node.as_ptr()).next });
    let even_head = even;

    while let (Some(odd_node), Some(even_node)) = (odd, even) {
        unsafe {
            (*odd_node.as_ptr()).next = (*even_node.as_ptr()).next;
            odd = (*even_node.as_ptr()).next;
            if let Some(next_even) = (*even_node.as_ptr()).next {
                (*even_node.as_ptr()).next = (*next_even.as_ptr()).next;
                even = (*next_even.as_ptr()).next;
            } else {
                break;
            }
        }
    }

    if let Some(mut odd_node) = odd {
        while let Some(next_odd) = unsafe { (*odd_node.as_ptr()).next } {
            odd_node = next_odd;
        }
        unsafe {
            (*odd_node.as_ptr()).next = even_head;
        }
    }

    head
}
}