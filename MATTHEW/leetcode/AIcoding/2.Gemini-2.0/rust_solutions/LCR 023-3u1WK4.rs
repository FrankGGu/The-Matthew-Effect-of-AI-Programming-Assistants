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
    pub fn get_intersection_node(
        head_a: Option<Box<ListNode>>,
        head_b: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut a = head_a.as_ref();
        let mut b = head_b.as_ref();

        if a.is_none() || b.is_none() {
            return None;
        }

        let mut a_ptr = a;
        let mut b_ptr = b;

        while a_ptr != b_ptr {
            if a_ptr.is_none() {
                a_ptr = head_b.as_ref();
            } else {
                a_ptr = a_ptr.unwrap().next.as_ref();
            }

            if b_ptr.is_none() {
                b_ptr = head_a.as_ref();
            } else {
                b_ptr = b_ptr.unwrap().next.as_ref();
            }
        }

        if a_ptr.is_none() {
            None
        } else {
            Some(Box::new(ListNode {
                val: a_ptr.unwrap().val,
                next: a_ptr.unwrap().next.clone(),
            }))
        }
    }
}

struct Solution;