use std::collections::HashMap;

impl Solution {
    pub fn shortest_supersequence(nums: Vec<i32>, target: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let m = target.len();
        let mut last_pos: HashMap<i32, Vec<i32>> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            last_pos.entry(num).or_insert(Vec::new()).push(i as i32);
        }

        let mut dp: Vec<i32> = vec![-1; n + 1];
        dp[0] = -1;

        for i in 0..m {
            let mut new_dp: Vec<i32> = vec![-1; n + 1];
            let t = target[i];

            if !last_pos.contains_key(&t) {
                return vec![];
            }

            let positions = last_pos.get(&t).unwrap();

            let mut j = 0;
            for k in 1..=n {
                if dp[k - 1] == -1 {
                    continue;
                }

                while j < positions.len() && positions[j] <= dp[k - 1] {
                    j += 1;
                }

                if j < positions.len() {
                    new_dp[k] = positions[j];
                }
            }

            dp = new_dp;
        }

        let mut start = -1;
        let mut end = n as i32;
        let mut min_len = n + 1;

        for k in 1..=n {
            if dp[k] != -1 {
                let len = dp[k] as usize - (k - 1);
                if len < min_len {
                    min_len = len;
                    start = (k - 1) as i32;
                    end = dp[k];
                }
            }
        }

        if start == -1 {
            return vec![];
        }

        vec![start, end]
    }
}