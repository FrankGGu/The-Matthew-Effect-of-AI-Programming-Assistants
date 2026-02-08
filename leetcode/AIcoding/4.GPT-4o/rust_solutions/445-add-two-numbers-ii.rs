#[derive(Debug, PartialEq, Eq)]
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

pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut stack1 = vec![];
    let mut stack2 = vec![];

    let mut current = l1;
    while let Some(node) = current {
        stack1.push(node.val);
        current = node.next;
    }

    current = l2;
    while let Some(node) = current {
        stack2.push(node.val);
        current = node.next;
    }

    let mut carry = 0;
    let mut result = None;

    while !stack1.is_empty() || !stack2.is_empty() || carry > 0 {
        let mut sum = carry;
        if let Some(val) = stack1.pop() {
            sum += val;
        }
        if let Some(val) = stack2.pop() {
            sum += val;
        }
        carry = sum / 10;
        let new_node = Some(Box::new(ListNode::new(sum % 10)));
        if result.is_none() {
            result = new_node;
        } else {
            let mut head = result.take();
            let mut tail = head.as_mut();
            while let Some(ref mut node) = tail {
                tail = node.next.as_mut();
            }
            if let Some(node) = new_node {
                tail = Some(node);
            }
            result = head;
        }
    }

    result
}