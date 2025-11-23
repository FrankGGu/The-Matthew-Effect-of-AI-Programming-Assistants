impl Solution {
    pub fn valid_subarray_size(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        let mut left = vec![-1; n];
        let mut right = vec![n as i32; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while let Some(&top) = stack.last() {
                if nums[top] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top) = stack.last() {
                left[i] = top as i32;
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while let Some(&top) = stack.last() {
                if nums[top] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top) = stack.last() {
                right[i] = top as i32;
            }
            stack.push(i);
        }

        for i in 0..n {
            let len = (right[i] - left[i] - 1) as i64;
            if nums[i] as i64 * len > threshold as i64 {
                return len as i32;
            }
        }

        -1
    }
}