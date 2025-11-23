struct Solution;

impl Solution {
    pub fn is_increasing_subarrays(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let k = k as usize;
        if k == 0 || k > n {
            return false;
        }

        let mut dp = vec![1; n];

        for i in 1..n {
            if nums[i] > nums[i - 1] {
                dp[i] = dp[i - 1] + 1;
            }
        }

        for i in 0..n {
            if dp[i] >= k {
                let start = i - k + 1;
                if start >= 0 {
                    let end = i;
                    let mut valid = true;
                    for j in 1..k {
                        if nums[start + j] <= nums[start + j - 1] {
                            valid = false;
                            break;
                        }
                    }
                    if valid {
                        return true;
                    }
                }
            }
        }

        false
    }
}