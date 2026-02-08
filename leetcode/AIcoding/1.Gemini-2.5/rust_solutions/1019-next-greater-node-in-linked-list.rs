impl Solution {
    pub fn next_greater_nodes(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut nums = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            nums.push(node.val);
            current = node.next;
        }

        let n = nums.len();
        if n == 0 {
            return Vec::new();
        }

        let mut result = vec![0; n];
        let mut stack: Vec<(usize, i32)> = Vec::new(); // Stores (index, value)

        for i in 0..n {
            let num = nums[i];
            while let Some(&(prev_idx, prev_val)) = stack.last() {
                if prev_val < num {
                    result[prev_idx] = num;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push((i, num));
        }

        result
    }
}