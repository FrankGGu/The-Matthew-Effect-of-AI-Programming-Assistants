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

pub fn merge_nodes(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = &mut dummy;

    while let Some(mut node) = head {
        head = node.next.take();
        let mut sum = 0;

        while let Some(next_node) = head {
            if next_node.val == 0 {
                head = next_node.next;
                break;
            }
            sum += next_node.val;
            head = next_node.next;
        }

        if sum != 0 {
            current.next = Some(Box::new(ListNode::new(sum)));
            current = current.next.as_mut().unwrap();
        }
    }

    dummy.next
}
}