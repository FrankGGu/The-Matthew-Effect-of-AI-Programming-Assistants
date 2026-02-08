impl Solution {
    pub fn merge_in_between(list1: Option<Box<ListNode>>, a: i32, b: i32, list2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode { val: 0, next: list1 });
        let mut prev = &mut dummy;

        for _ in 0..a {
            prev = prev.next.as_mut().unwrap();
        }

        let mut after_a = prev.next.take();

        for _ in a..=b {
            after_a = after_a.unwrap().next;
        }

        let mut list2_tail = &list2;
        while let Some(node) = list2_tail {
            list2_tail = &node.next;
        }

        prev.next = list2;

        while prev.next.is_some() {
            prev = prev.next.as_mut().unwrap();
        }

        prev.next = after_a;

        dummy.next
    }
}