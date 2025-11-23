impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            let mut cost = i32::MAX;
            let mut count = std::collections::HashMap::new();
            let mut trim = 0;

            for j in i..n {
                let num = nums[j];
                *count.entry(num).or_insert(0) += 1;
                if count[&num] > 1 {
                    if count[&num] == 2 {
                        trim += 2;
                    } else {
                        trim += 1;
                    }
                }

                let current_cost = k + trim;

                if current_cost >= i32::MAX {
                    continue;
                }

                if dp[j + 1] >= i32::MAX {
                    continue;
                }

                cost = cost.min(current_cost + dp[j + 1]);
            }
            dp[i] = cost;
        }

        dp[0]
    }
}