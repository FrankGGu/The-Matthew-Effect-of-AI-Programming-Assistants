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
    pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut slow = head.as_ref();
        let mut fast = head.as_ref();

        while let (Some(s), Some(f)) = (slow, fast) {
            slow = s.next.as_ref();
            fast = f.next.as_ref()?.next.as_ref();

            if slow == fast {
                let mut ptr1 = head.as_ref();
                let mut ptr2 = slow;

                while ptr1 != ptr2 {
                    ptr1 = ptr1?.next.as_ref();
                    ptr2 = ptr2?.next.as_ref();
                }

                return ptr1.map(|node| node.clone());
            }
        }

        None
    }
}

struct Solution;