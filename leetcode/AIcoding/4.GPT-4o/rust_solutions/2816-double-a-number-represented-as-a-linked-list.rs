#[derive(Clone, PartialEq, Eq)]
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

pub fn double_it(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut carry = 0;
    let mut current = head;
    let mut result = None;
    let mut tail = &mut result;

    while current.is_some() || carry > 0 {
        let mut sum = carry;
        if let Some(node) = current {
            sum += node.val * 2;
            current = node.next;
        }
        carry = sum / 10;
        let new_node = Some(Box::new(ListNode::new(sum % 10)));
        tail = &mut tail.insert(new_node).as_mut().unwrap().next;
    }

    result
}