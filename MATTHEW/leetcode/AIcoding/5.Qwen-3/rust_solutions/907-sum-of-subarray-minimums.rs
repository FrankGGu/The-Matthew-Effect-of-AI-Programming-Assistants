struct Solution;

impl Solution {
    pub fn sum_subarray_mins(nums: Vec<i32>) -> i32 {
        let mod_val = 10i32.pow(9) + 7;
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            let mut count = 1;
            while !stack.is_empty() && nums[*stack.last().unwrap()] > nums[i] {
                count += left[stack.pop().unwrap()];
            }
            left[i] = count;
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            let mut count = 1;
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                count += right[stack.pop().unwrap()];
            }
            right[i] = count;
            stack.push(i);
        }

        let mut result = 0;
        for i in 0..n {
            result = (result + nums[i] * left[i] * right[i]) % mod_val;
        }

        result
    }
}