impl Solution {
    pub fn max_envelopes(envelopes: Vec<Vec<i32>>) -> i32 {
        let mut envelopes = envelopes;
        envelopes.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut dp: Vec<i32> = Vec::new();
        for envelope in envelopes {
            let height = envelope[1];
            let i = dp.binary_search(&height).unwrap_or_else(|x| x);
            if i == dp.len() {
                dp.push(height);
            } else {
                dp[i] = height;
            }
        }

        dp.len() as i32
    }
}