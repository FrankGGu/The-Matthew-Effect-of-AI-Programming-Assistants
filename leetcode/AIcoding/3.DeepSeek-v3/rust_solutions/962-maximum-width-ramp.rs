impl Solution {
    pub fn max_width_ramp(nums: Vec<i32>) -> i32 {
        let mut stack = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if stack.is_empty() || nums[*stack.last().unwrap()] > num {
                stack.push(i);
            }
        }

        let mut max_width = 0;
        for j in (0..nums.len()).rev() {
            while !stack.is_empty() && nums[j] >= nums[*stack.last().unwrap()] {
                let i = stack.pop().unwrap();
                max_width = max_width.max(j - i);
            }
        }

        max_width as i32
    }
}