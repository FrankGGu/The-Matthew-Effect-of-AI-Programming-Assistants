use crate::ListNode;

pub struct Solution;

impl Solution {
    pub fn reverse_k_group(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode::new(0)));
        let mut prev = dummy.as_mut();
        let mut current = head;

        while current.is_some() {
            let mut count = 0;
            let mut temp = current.clone();
            while let Some(node) = temp {
                count += 1;
                temp = node.next;
                if count == k {
                    break;
                }
            }
            if count < k {
                prev.as_mut().unwrap().next = current;
                break;
            }
            let mut tail = current;
            let mut next = None;
            for _ in 0..k {
                if let Some(mut node) = tail {
                    tail = node.next.take();
                    node.next = next;
                    next = Some(node);
                }
            }
            prev.as_mut().unwrap().next = next;
            while prev.as_mut().unwrap().next.is_some() {
                prev = &mut prev.as_mut().unwrap().next;
            }
            current = tail;
        }
        dummy.unwrap().next
    }
}