impl Solution {
    pub fn num_components(head: Option<Box<ListNode>>, nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut current = head;
        let mut in_set = false;
        let nums_set: std::collections::HashSet<i32> = nums.into_iter().collect();

        while let Some(node) = current {
            if nums_set.contains(&node.val) {
                if !in_set {
                    count += 1;
                    in_set = true;
                }
            } else {
                in_set = false;
            }
            current = node.next;
        }

        count
    }
}