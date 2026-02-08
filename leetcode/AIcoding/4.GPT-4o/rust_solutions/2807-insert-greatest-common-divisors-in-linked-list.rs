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

pub fn insert_greatest_common_divisors(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            gcd(b, a % b)
        }
    }

    let mut current = head;
    let mut new_head = None;
    let mut tail = &mut new_head;

    while let Some(mut node) = current {
        current = node.next.take();
        tail = &mut tail.insert(node);
        if let Some(next_node) = current.as_ref() {
            let g = gcd(node.val, next_node.val);
            tail = &mut tail.as_mut().unwrap().next.insert(Box::new(ListNode::new(g)));
        }
    }

    new_head
}