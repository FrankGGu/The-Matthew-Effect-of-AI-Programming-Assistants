impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current = head;
        let mut head_ref = current.as_mut();

        while let Some(node) = head_ref {
            let mut next_node = node.next.as_mut();
            while let Some(next_n) = next_node {
                if node.val == next_n.val {
                    node.next = next_n.next.take();
                    next_node = node.next.as_mut();
                } else {
                    break;
                }
            }
            head_ref = node.next.as_mut();
        }

        current
    }
}

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

struct Solution;