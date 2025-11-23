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

pub fn odd_even_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut odd_head = None;
    let mut even_head = None;
    let mut odd_tail = &mut odd_head;
    let mut even_tail = &mut even_head;
    let mut current = head;
    let mut index = 1;

    while let Some(mut node) = current {
        current = node.next.take();
        if index % 2 == 1 {
            odd_tail = &mut odd_tail.insert(node).next;
        } else {
            even_tail = &mut even_tail.insert(node).next;
        }
        index += 1;
    }

    if let Some(even) = even_head {
        odd_tail.as_mut().unwrap().next = Some(even);
    }

    odd_head
}