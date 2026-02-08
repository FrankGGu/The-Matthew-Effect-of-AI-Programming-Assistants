impl Solution {
    pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
        let mut values = Vec::new();
        let mut current = head.as_ref();
        while let Some(node) = current {
            values.push(node.val);
            current = node.next.as_ref();
        }

        let n = values.len();
        let mut max_sum = 0;
        for i in 0..n / 2 {
            let sum = values[i] + values[n - 1 - i];
            if sum > max_sum {
                max_sum = sum;
            }
        }
        max_sum
    }
}