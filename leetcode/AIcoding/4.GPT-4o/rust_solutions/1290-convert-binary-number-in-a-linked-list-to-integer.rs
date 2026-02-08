#[derive(List)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn get_decimal_value(head: Option<Box<ListNode>>) -> i32 {
    let mut num = 0;
    let mut current = head;

    while let Some(node) = current {
        num = (num << 1) | node.val;
        current = node.next;
    }

    num
}