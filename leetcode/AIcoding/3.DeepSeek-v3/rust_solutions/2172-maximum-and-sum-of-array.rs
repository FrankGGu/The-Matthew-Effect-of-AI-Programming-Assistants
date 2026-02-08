impl Solution {
    pub fn maximum_and_sum(nums: Vec<i32>, num_slots: i32) -> i32 {
        let n = nums.len();
        let m = num_slots as usize;
        let mut dp = vec![-1; 1 << (2 * m)];
        dp[0] = 0;

        for mask in 0..(1 << (2 * m)) {
            if dp[mask] == -1 {
                continue;
            }
            let cnt = mask.count_ones() as usize;
            if cnt >= n {
                continue;
            }
            for slot in 0..m {
                if (mask >> (2 * slot)) & 3 < 2 {
                    let new_mask = mask | (1 << (2 * slot));
                    let and = nums[cnt] & (slot as i32 + 1);
                    if dp[new_mask] < dp[mask] + and {
                        dp[new_mask] = dp[mask] + and;
                    }
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}