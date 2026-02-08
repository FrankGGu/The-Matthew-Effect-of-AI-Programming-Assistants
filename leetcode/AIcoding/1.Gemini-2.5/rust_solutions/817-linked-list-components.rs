use std::collections::HashSet;

impl Solution {
    pub fn num_components(head: Option<Box<ListNode>>, nums: Vec<i32>) -> i32 {
        let mut num_set: HashSet<i32> = nums.into_iter().collect();
        let mut current = head;
        let mut components = 0;
        let mut in_component = false;

        while let Some(node) = current {
            if num_set.contains(&node.val) {
                if !in_component {
                    components += 1;
                    in_component = true;
                }
            } else {
                in_component = false;
            }
            current = node.next;
        }

        components
    }
}