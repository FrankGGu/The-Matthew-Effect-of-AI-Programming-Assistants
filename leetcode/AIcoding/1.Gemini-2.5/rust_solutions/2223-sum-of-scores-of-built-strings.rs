impl Solution {
    pub fn sum_scores(s: String) -> i64 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_bytes = s.as_bytes();
        let mut z = vec![0; n];
        z[0] = n; 

        let mut l = 0;
        let mut r = 0; 

        let mut total_score: i64 = n as i64; 

        for i in 1..n {
            if i <= r {
                z[i] = std::cmp::min(r - i + 1, z[i - l]);
            }

            while i + z[i] < n && s_bytes[z[i]] == s_bytes[i + z[i]] {
                z[i] += 1;
            }

            if i + z[i] - 1 > r {
                l = i;
                r = i + z[i] - 1;
            }
            total_score += z[i] as i64;
        }

        total_score
    }
}