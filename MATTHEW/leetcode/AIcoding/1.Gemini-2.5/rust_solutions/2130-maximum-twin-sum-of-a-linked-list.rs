impl Solution {
    pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
        let mut values = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            values.push(node.val);
            current = node.next;
        }

        let n = values.len();
        let mut max_twin_sum = 0;
        for i in 0..n / 2 {
            let twin_sum = values[i] + values[n - 1 - i];
            max_twin_sum = max_twin_sum.max(twin_sum);
        }
        max_twin_sum
    }
}