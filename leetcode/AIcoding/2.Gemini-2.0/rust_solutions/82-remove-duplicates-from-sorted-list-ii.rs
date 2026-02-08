impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: -1, next: head }));
        let mut current = &mut dummy;

        while let Some(mut node) = current.as_mut() {
            if node.next.is_none() || node.next.as_ref().unwrap().next.is_none() {
                break;
            }

            let mut next_node = node.next.take();
            let mut next_next_node = next_node.as_mut().unwrap().next.take();

            if next_node.as_ref().unwrap().val == next_next_node.as_ref().unwrap().val {
                let duplicate_val = next_node.as_ref().unwrap().val;
                while let Some(n) = next_next_node {
                    if n.val != duplicate_val {
                        next_node = Some(n);
                        break;
                    }
                    next_next_node = n.next;
                }
                node.next = next_next_node;
                current = &mut dummy; 
            } else {
                node.next = next_node;
                node.next.as_mut().unwrap().next = next_next_node;
                current = &mut node.next;
            }
        }

        dummy.unwrap().next
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