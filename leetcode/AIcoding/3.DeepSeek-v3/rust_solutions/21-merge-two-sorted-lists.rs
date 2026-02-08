impl Solution {
    pub fn merge_two_lists(list1: Option<Box<ListNode>>, list2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        match (list1, list2) {
            (None, None) => None,
            (Some(l), None) => Some(l),
            (None, Some(r)) => Some(r),
            (Some(l), Some(r)) => {
                if l.val <= r.val {
                    Some(Box::new(ListNode {
                        val: l.val,
                        next: Self::merge_two_lists(l.next, Some(r)),
                    }))
                } else {
                    Some(Box::new(ListNode {
                        val: r.val,
                        next: Self::merge_two_lists(Some(l), r.next),
                    }))
                }
            }
        }
    }
}