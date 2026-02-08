impl Solution {
    pub fn max_width_ramp(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut stack: Vec<usize> = Vec::new();
        for i in 0..n {
            if stack.is_empty() || nums[i] < nums[*stack.last().unwrap()] {
                stack.push(i);
            }
        }

        let mut max_width = 0;
        for j in (0..n).rev() {
            while !stack.is_empty() && nums[j] >= nums[*stack.last().unwrap()] {
                max_width = max_width.max((j - stack.pop().unwrap()) as i32);
            }
        }

        max_width
    }
}