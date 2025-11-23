use crate::ListNode;

pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
    let mut values = Vec::new();
    let mut current = head;

    while let Some(node) = current {
        values.push(node.val);
        current = node.next;
    }

    let n = values.len();
    let mut max_sum = 0;

    for i in 0..n / 2 {
        max_sum = max_sum.max(values[i] + values[n - 1 - i]);
    }

    max_sum
}