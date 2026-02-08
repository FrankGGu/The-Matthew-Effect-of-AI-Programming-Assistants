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
    pub fn delete_nodes(
        head: Option<Box<ListNode>>,
        to_delete: Vec<i32>,
    ) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode {
            val: -1,
            next: head,
        }));
        let mut current = &mut dummy;

        while let Some(node) = current {
            if to_delete.contains(&node.next.as_ref().map(|n| n.val).unwrap_or(-2)) {
                current.as_mut().unwrap().next = node.next.take().unwrap().next;
            } else {
                current = &mut current.as_mut().unwrap().next;
            }
        }

        dummy.unwrap().next
    }
}

struct Solution;