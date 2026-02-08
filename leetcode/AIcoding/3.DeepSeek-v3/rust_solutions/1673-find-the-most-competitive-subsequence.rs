impl Solution {
    pub fn most_competitive(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut stack = Vec::with_capacity(k);
        let n = nums.len();

        for (i, &num) in nums.iter().enumerate() {
            while !stack.is_empty() && num < *stack.last().unwrap() {
                let remaining = n - i;
                if stack.len() + remaining > k {
                    stack.pop();
                } else {
                    break;
                }
            }
            if stack.len() < k {
                stack.push(num);
            }
        }

        stack
    }
}