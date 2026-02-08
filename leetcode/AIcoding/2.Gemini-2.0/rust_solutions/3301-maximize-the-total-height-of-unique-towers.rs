use std::collections::HashMap;

impl Solution {
    pub fn maximize_tower_height(n: i32, x: i32, heights: Vec<i32>) -> i64 {
        let mut count: HashMap<i32, i32> = HashMap::new();
        for &h in &heights {
            *count.entry(h).or_insert(0) += 1;
        }

        let mut nums: Vec<(i32, i32)> = count.into_iter().collect();
        nums.sort_by_key(|&(h, _)| h);

        let mut dp: Vec<i64> = vec![0; (n + 1) as usize];

        for i in 0..(nums.len()) {
            let (height, cnt) = nums[i];
            for j in (1..(n + 1)).rev() {
                if j >= cnt {
                    dp[j as usize] = std::cmp::max(dp[j as usize], dp[(j - cnt) as usize] + height as i64 * cnt as i64);
                }
            }
        }

        let mut ans = 0;
        for i in 1..(n + 1) {
            ans = std::cmp::max(ans, dp[i as usize] - x as i64 * (n - i) as i64);
        }

        ans
    }
}