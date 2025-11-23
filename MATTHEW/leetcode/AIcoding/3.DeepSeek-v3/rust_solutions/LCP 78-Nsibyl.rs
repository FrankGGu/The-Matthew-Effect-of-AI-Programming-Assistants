impl Solution {
    pub fn max_envelopes(envelopes: Vec<Vec<i32>>) -> i32 {
        let mut envelopes = envelopes;
        envelopes.sort_by(|a, b| {
            if a[0] == b[0] {
                b[1].cmp(&a[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let mut dp = Vec::new();
        for env in envelopes {
            let h = env[1];
            let idx = dp.binary_search(&h).unwrap_or_else(|x| x);
            if idx == dp.len() {
                dp.push(h);
            } else {
                dp[idx] = h;
            }
        }
        dp.len() as i32
    }
}