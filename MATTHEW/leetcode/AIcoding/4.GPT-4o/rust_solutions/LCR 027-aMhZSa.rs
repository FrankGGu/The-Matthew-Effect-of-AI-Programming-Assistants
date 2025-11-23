#[derive(PartialEq, Eq, Clone, Debug)]
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

pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
    let mut slow = &head;
    let mut fast = &head;
    let mut stack = Vec::new();

    while let Some(ref node) = fast {
        stack.push(node.val);
        fast = &node.next;
        if let Some(ref next_node) = fast {
            fast = &next_node.next;
        }
    }

    slow = &head;
    while let Some(val) = stack.pop() {
        if let Some(node) = slow {
            if node.val != val {
                return false;
            }
            slow = &node.next;
        }
    }

    true
}