impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode { val: 0, next: head });
    let mut current = &mut dummy.next;

    while let Some(node) = current {
        if let Some(next) = &node.next {
            if node.val == next.val {
                *current = node.next.as_ref().unwrap().next.clone();
            } else {
                current = &mut node.next;
            }
        } else {
            break;
        }
    }

    dummy.next
}
}