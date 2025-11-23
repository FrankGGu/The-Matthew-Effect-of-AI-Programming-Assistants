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

pub fn reverse_even_length_groups(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
    let mut current = dummy.as_mut().unwrap().next.take();
    let mut length = 1;
    let mut count = 0;

    while current.is_some() {
        let mut group = Vec::new();
        let mut temp = current.clone();

        while temp.is_some() && group.len() < length {
            group.push(temp.unwrap().val);
            temp = temp.unwrap().next;
        }

        if group.len() % 2 == 0 {
            group.reverse();
        }

        let mut prev = dummy.as_mut().unwrap();
        for val in group {
            prev.next = Some(Box::new(ListNode { val, next: None }));
            prev = prev.next.as_mut().unwrap();
        }

        current = temp;
        length += 1;
    }

    dummy.unwrap().next
}
}