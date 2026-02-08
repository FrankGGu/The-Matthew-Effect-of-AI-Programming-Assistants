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
    pub fn merge_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode::new(0));
        let mut tail = &mut dummy;
        let mut current = head;
        let mut sum = 0;

        while let Some(mut node) = current {
            if node.val == 0 {
                if sum != 0 {
                    tail.next = Some(Box::new(ListNode::new(sum)));
                    tail = tail.next.as_mut().unwrap();
                    sum = 0;
                }
            } else {
                sum += node.val;
            }
            current = node.next;
        }

        dummy.next
    }
}

struct Solution;