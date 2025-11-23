pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { val, next: None }
    }
}

pub fn merge_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut current = &mut dummy;
    let mut sum = 0;
    let mut node = head;

    while let Some(mut n) = node {
        if n.val == 0 {
            if sum > 0 {
                current.next = Some(Box::new(ListNode::new(sum)));
                current = current.next.as_mut().unwrap();
                sum = 0;
            }
        } else {
            sum += n.val;
        }
        node = n.next;
    }

    dummy.next
}