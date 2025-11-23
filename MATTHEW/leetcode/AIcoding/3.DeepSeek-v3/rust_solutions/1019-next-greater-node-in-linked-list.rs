impl Solution {
    pub fn next_larger_nodes(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut nums = Vec::new();
        let mut current = &head;
        while let Some(node) = current {
            nums.push(node.val);
            current = &node.next;
        }

        let mut res = vec![0; nums.len()];
        let mut stack = Vec::new();

        for i in (0..nums.len()).rev() {
            while let Some(&last) = stack.last() {
                if last <= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&last) = stack.last() {
                res[i] = last;
            }
            stack.push(nums[i]);
        }

        res
    }
}