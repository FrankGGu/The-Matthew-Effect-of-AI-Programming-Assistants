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
    pub fn merge_in_between(
        list1: Option<Box<ListNode>>,
        a: i32,
        b: i32,
        list2: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut head = list1;
        let mut current = &mut head;
        let mut count = 0;
        let mut a_node = None;
        let mut b_node = None;

        while let Some(node) = current {
            if count == a - 1 {
                a_node = Some(current as *mut Option<Box<ListNode>>);
            }
            if count == b {
                b_node = Some(node.next.take());
                break;
            }
            current = &mut node.next;
            count += 1;
        }

        if let Some(a_ptr) = a_node {
            unsafe {
                *a_ptr = list2;
                let mut tail = &mut *a_ptr;
                while let Some(node) = tail {
                    if node.next.is_none() {
                        tail = &mut node.next;
                        break;
                    }
                    tail = &mut node.next;
                }
                if let Some(b_next) = b_node {
                    *tail = Some(Box::new(ListNode { val: b_next.val, next: b_next.next }));
                }
            }
        }

        head
    }
}

struct Solution;