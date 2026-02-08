use std::collections::HashSet;

impl Solution {
    pub fn delete_nodes(head: Option<Box<ListNode>>, nums: Vec<i32>) -> Option<Box<ListNode>> {
        let nums_set: HashSet<_> = nums.into_iter().collect();
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut prev = &mut dummy;

        while let Some(node) = prev {
            while let Some(next_node) = &mut node.next {
                if nums_set.contains(&next_node.val) {
                    node.next = next_node.next.take();
                } else {
                    break;
                }
            }
            prev = &mut node.next;
        }

        dummy.unwrap().next
    }
}