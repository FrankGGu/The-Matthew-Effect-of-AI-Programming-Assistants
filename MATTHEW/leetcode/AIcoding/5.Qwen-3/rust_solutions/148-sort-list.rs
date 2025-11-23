impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    fn merge(left: Option<Box<ListNode>>, right: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode::new(0));
        let mut current = &mut dummy;

        let mut left = left;
        let mut right = right;

        while left.is_some() && right.is_some() {
            if left.as_ref().unwrap().val <= right.as_ref().unwrap().val {
                current.next = left;
                left = current.next.as_mut().unwrap().next.take();
            } else {
                current.next = right;
                right = current.next.as_mut().unwrap().next.take();
            }
            current = current.next.as_mut().unwrap();
        }

        current.next = left.or(right);

        dummy.next
    }

    fn split(head: Option<Box<ListNode>>) -> (Option<Box<ListNode>>, Option<Box<ListNode>>) {
        let mut slow = head;
        let mut fast = head.as_ref().and_then(|n| n.next.as_ref().map(|n| n.clone()));

        while fast.is_some() {
            slow = slow.as_ref().and_then(|n| n.next.as_ref().map(|n| n.clone()));
            fast = fast.as_ref().and_then(|n| n.next.as_ref().map(|n| n.clone())).and_then(|n| n.next.as_ref().map(|n| n.clone()));
        }

        let mid = slow;
        let right = mid.as_ref().and_then(|n| n.next.as_ref().map(|n| n.clone()));
        if let Some(ref mut node) = mid {
            node.next = None;
        }

        (head, right)
    }

    fn merge_sort(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        let (left, right) = split(head);
        let left = merge_sort(left);
        let right = merge_sort(right);
        merge(left, right)
    }

    merge_sort(head)
}
}