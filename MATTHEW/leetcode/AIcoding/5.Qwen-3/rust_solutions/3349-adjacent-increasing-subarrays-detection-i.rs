struct Solution;

impl Solution {
    pub fn is_increasing_subarrays(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let k = k as usize;

        for i in 0..=n - k * 2 {
            let mut increasing = true;
            for j in 0..k - 1 {
                if nums[i + j + 1] <= nums[i + j] {
                    increasing = false;
                    break;
                }
            }
            if increasing {
                for j in 0..k - 1 {
                    if nums[i + k + j + 1] <= nums[i + k + j] {
                        increasing = false;
                        break;
                    }
                }
                if increasing {
                    return true;
                }
            }
        }

        false
    }
}