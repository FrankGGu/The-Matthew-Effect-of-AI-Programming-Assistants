impl Solution {
    pub fn split_array(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let n = nums.len();
        let mut dp = vec![0; n];
        let mut prime_min_indices = HashMap::new();

        for i in 0..n {
            let mut x = nums[i];
            let mut min_prev = if i == 0 { 0 } else { dp[i - 1] + 1 };
            let mut factors = Vec::new();

            let mut d = 2;
            while d * d <= x {
                if x % d == 0 {
                    factors.push(d);
                    while x % d == 0 {
                        x /= d;
                    }
                }
                d += 1;
            }
            if x > 1 {
                factors.push(x);
            }

            for &p in &factors {
                if let Some(&idx) = prime_min_indices.get(&p) {
                    let prev = if idx == 0 { 0 } else { dp[idx - 1] };
                    if prev < min_prev {
                        min_prev = prev;
                    }
                }
                prime_min_indices.insert(p, i);
            }

            dp[i] = min_prev;
        }

        dp[n - 1] + 1
    }
}