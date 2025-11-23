impl Solution {
    pub fn longest_nice_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut bit_counts = vec![0; 30]; 
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..n {
            for k in 0..30 {
                if ((nums[right] >> k) & 1) == 1 {
                    bit_counts[k] += 1;
                }
            }

            while {
                let current_window_len = (right - left + 1) as i32;
                let mut is_nice = true;
                for k in 0..30 {
                    if bit_counts[k] > 0 && bit_counts[k] < current_window_len {
                        is_nice = false;
                        break;
                    }
                }
                !is_nice
            } {
                for k in 0..30 {
                    if ((nums[left] >> k) & 1) == 1 {
                        bit_counts[k] -= 1;
                    }
                }
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}