use std::collections::HashMap;

impl Solution {
    pub fn remove_zero_sum_sublists(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode { val: 0, next: head });
        let mut prefix_sum = 0;
        let mut map = HashMap::new();
        let mut current = dummy.as_mut();

        while let Some(node) = current.next.take() {
            prefix_sum += node.val;
            if let Some(prev_node) = map.get_mut(&prefix_sum) {
                let mut to_remove = prev_node.next.take();
                let mut temp_sum = prefix_sum;
                while let Some(remove_node) = to_remove {
                    temp_sum += remove_node.val;
                    if temp_sum != prefix_sum {
                        map.remove(&temp_sum);
                    }
                    to_remove = remove_node.next;
                }
                current.next = node.next;
            } else {
                if prefix_sum == 0 {
                    map.clear();
                    current.next = Some(node);
                    current = current.next.as_mut().unwrap();
                } else {
                    map.insert(prefix_sum, current);
                    current.next = Some(node);
                    current = current.next.as_mut().unwrap();
                }
            }
        }

        dummy.next
    }
}