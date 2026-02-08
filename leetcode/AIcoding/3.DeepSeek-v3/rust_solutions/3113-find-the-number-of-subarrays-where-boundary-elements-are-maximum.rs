impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] < nums[i] {
                stack.pop();
            }
            left[i] = if stack.is_empty() { -1 } else { *stack.last().unwrap() as i32 };
            stack.push(i);
        }

        stack.clear();
        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] <= nums[i] {
                stack.pop();
            }
            right[i] = if stack.is_empty() { n as i32 } else { *stack.last().unwrap() as i32 };
            stack.push(i);
        }

        let mut res = 0;
        for i in 0..n {
            res += ((i as i32 - left[i]) * (right[i] - i as i32)) as i64;
        }
        res
    }
}