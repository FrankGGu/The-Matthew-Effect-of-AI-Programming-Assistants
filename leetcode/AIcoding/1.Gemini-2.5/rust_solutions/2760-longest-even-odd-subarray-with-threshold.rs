impl Solution {
    pub fn longest_even_odd_subarray_with_threshold(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        let mut max_len = 0;

        for i in 0..n {
            if nums[i] % 2 == 0 && nums[i] <= threshold {
                let mut current_len = 1;
                let mut prev_parity = 0; // 0 for even, 1 for odd

                for j in (i + 1)..n {
                    if nums[j] <= threshold && nums[j] % 2 != prev_parity {
                        current_len += 1;
                        prev_parity = nums[j] % 2;
                    } else {
                        break;
                    }
                }
                max_len = max_len.max(current_len);
            }
        }

        max_len
    }
}