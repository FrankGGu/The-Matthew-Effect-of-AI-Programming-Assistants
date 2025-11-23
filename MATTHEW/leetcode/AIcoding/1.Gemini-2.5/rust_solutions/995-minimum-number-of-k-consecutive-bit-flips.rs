struct Solution;

impl Solution {
    pub fn min_k_bit_flips(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut nums = nums; 

        let mut flips = 0;
        let mut current_flips_active_at_i = 0;

        for i in 0..n {
            if i >= k && nums[i - k] == 2 {
                current_flips_active_at_i -= 1;
            }

            if (nums[i] + current_flips_active_at_i) % 2 == 0 {
                if i + k > n {
                    return -1;
                }

                flips += 1;
                current_flips_active_at_i += 1;
                nums[i] = 2; 
            }
        }

        flips
    }
}