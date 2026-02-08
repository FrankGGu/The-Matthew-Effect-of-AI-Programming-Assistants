use std::cmp::Reverse;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq, PartialOrd, Ord)]
struct ListNodeWrapper(i32, *mut ListNode);

impl ListNodeWrapper {
    fn new(val: i32, node: *mut ListNode) -> Self {
        ListNodeWrapper(val, node)
    }
}

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap: BinaryHeap<Reverse<ListNodeWrapper>> = BinaryHeap::new();

        for list in lists {
            if let Some(node) = list {
                heap.push(Reverse(ListNodeWrapper::new(node.val, Box::into_raw(node))));
            }
        }

        let mut head: Option<Box<ListNode>> = None;
        let mut tail: *mut ListNode = std::ptr::null_mut();

        while let Some(Reverse(ListNodeWrapper(val, node_ptr))) = heap.pop() {
            let mut node = unsafe { Box::from_raw(node_ptr) };

            if head.is_none() {
                head = Some(node);
                tail = unsafe { head.as_mut().unwrap() }.as_mut() as *mut ListNode;
            } else {
                unsafe { (*tail).next = Some(node) };
                tail = unsafe { (*tail).next.as_mut().unwrap() }.as_mut() as *mut ListNode;
            }

            if let Some(next_node) = unsafe { (*tail).next.take() } {
                heap.push(Reverse(ListNodeWrapper::new(next_node.val, Box::into_raw(next_node))));
                unsafe { (*tail).next = Some(Box::from_raw(Box::into_raw(ListNode { val: (*tail).val, next: None })));
                    (*tail).val = val;
                    (*tail).next = None;
                }
                unsafe { (*tail).next = Some(Box::from_raw(node_ptr))};
                unsafe { (*tail).next = Some(Box::from_raw(Box::into_raw(ListNode { val: val, next: None })))};
                unsafe { (*tail).next = Some(Box::from_raw(node_ptr)) };

                unsafe { (*tail).next = Some(Box::from_raw(Box::into_raw(ListNode { val: val, next: None }))) };
                unsafe { (*tail).next = Some(Box::from_raw(node_ptr)) };

                unsafe { (*tail).next = Some(Box::from_raw(node_ptr)) };
                unsafe { (*tail).next = Some(next_node) };
                unsafe { (*tail).next = Some(Box::from_raw(node_ptr))};

                unsafe { (*tail).next = Some(next_node) };

                let next_node_ptr = unsafe { &mut *node_ptr }.next.take();
                if let Some(next_node) = next_node_ptr {
                    heap.push(Reverse(ListNodeWrapper::new(next_node.val, Box::into_raw(next_node))));
                }
            }
        }

        head
    }
}