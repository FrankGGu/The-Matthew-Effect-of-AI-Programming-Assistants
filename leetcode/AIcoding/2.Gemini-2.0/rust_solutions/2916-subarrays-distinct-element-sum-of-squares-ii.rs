const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans: i64 = 0;
        let mut last_sum: i64 = 0;
        let mut cnt: std::collections::HashMap<i32, i32> = std::collections::HashMap::new();
        for i in 0..n {
            let num = nums[i];
            let mut new_cnt: std::collections::HashMap<i32, i32> = std::collections::HashMap::new();
            new_cnt.insert(num, 1);
            let mut current_sum: i64 = 0;
            for (&k, &v) in &cnt {
                let new_count = new_cnt.entry(k).or_insert(0);
                *new_count += v;
            }
            cnt = new_cnt;
            for (&k, &v) in &cnt {
                current_sum = (current_sum + (k as i64) * (k as i64) % MOD * (v as i64) % MOD) % MOD;
            }
            ans = (ans + current_sum) % MOD;
        }

        ans as i32
    }
}