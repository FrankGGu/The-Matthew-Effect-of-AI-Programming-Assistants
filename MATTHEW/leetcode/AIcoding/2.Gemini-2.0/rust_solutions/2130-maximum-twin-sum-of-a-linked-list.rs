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

impl Solution {
    pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
        let mut slow = &head;
        let mut fast = &head;

        while fast.as_ref().unwrap().next.is_some() && fast.as_ref().unwrap().next.as_ref().unwrap().next.is_some() {
            slow = &slow.as_ref().unwrap().next;
            fast = &fast.as_ref().unwrap().next.as_ref().unwrap().next;
        }

        let mut second_half = slow.as_ref().unwrap().next.take();
        let mut prev = None;
        let mut curr = second_half;

        while let Some(mut node) = curr {
            let next = node.next.take();
            node.next = prev;
            prev = Some(node);
            curr = next;
        }

        let mut max_sum = 0;
        let mut head_ptr = &head;
        let mut second_ptr = &prev;

        while let Some(node) = second_ptr {
            let sum = head_ptr.as_ref().unwrap().val + node.val;
            max_sum = max_sum.max(sum);
            head_ptr = &head_ptr.as_ref().unwrap().next;
            second_ptr = &node.next;
        }

        max_sum
    }
}