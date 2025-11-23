#[derive(PartialEq, Eq, Clone, Debug)]
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

impl Solution {
    pub fn reverse_even_length_groups(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head = head;
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut current = dummy.as_mut();
        let mut k = 1;

        while current.is_some() {
            let mut start = current.unwrap();
            let mut tail = start.next.as_mut();
            let mut count = 0;
            let mut stack = Vec::new();

            while count < k && tail.is_some() {
                stack.push(tail.take());
                tail = start.next.as_mut().unwrap().next.as_mut();
                count += 1;
            }

            if count % 2 == 0 {
                while let Some(mut node) = stack.pop() {
                    let next = start.next.take();
                    node.next = next;
                    start.next = Some(node);
                    start = start.next.as_mut().unwrap();
                }
            } else {
                while let Some(mut node) = stack.pop() {
                    let next = start.next.take();
                    node.next = next;
                    start.next = Some(node);
                    start = start.next.as_mut().unwrap();
                }
                start = current.unwrap();
                for _ in 0..count {
                    start = start.next.as_mut().unwrap();
                }
            }

            current = Some(start);
            current = current.unwrap().next.as_mut();

            k += 1;
        }

        dummy.unwrap().next
    }
}