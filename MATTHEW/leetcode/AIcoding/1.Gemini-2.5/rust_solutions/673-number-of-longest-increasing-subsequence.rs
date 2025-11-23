impl Solution {
    pub fn find_number_of_lis(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut dp = vec![1; n];
        let mut count = vec![1; n];

        for i in 0..n {
            for j in 0..i {
                if nums[i] > nums[j] {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1;
                        count[i] = count[j];
                    } else if dp[j] + 1 == dp[i] {
                        count[i] += count[j];
                    }
                }
            }
        }

        let mut max_len = 0;
        for &len in dp.iter() {
            if len > max_len {
                max_len = len;
            }
        }

        let mut total_count = 0;
        for i in 0..n {
            if dp[i] == max_len {
                total_count += count[i];
            }
        }

        total_count
    }
}