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

pub fn next_larger_nodes(head: Option<Box<ListNode>>) -> Vec<i32> {
    let mut result = vec![];
    let mut stack = vec![];
    let mut current = head;

    while let Some(node) = current {
        result.push(node.val);
        current = node.next;
    }

    let n = result.len();
    let mut answer = vec![0; n];

    for i in (0..n).rev() {
        while let Some(&j) = stack.last() {
            if result[j] <= result[i] {
                stack.pop();
            } else {
                answer[i] = result[j];
                break;
            }
        }
        stack.push(i);
    }

    answer
}