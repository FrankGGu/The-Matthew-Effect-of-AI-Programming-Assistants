impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut prefix_ones = vec![0; n + 1];
        for i in 0..n {
            prefix_ones[i + 1] = prefix_ones[i] + if s[i] == b'1' { 1 } else { 0 };
        }

        let mut res = i32::MAX;
        for i in 0..=n {
            let flips = prefix_ones[i] + (n - i) as i32 - (prefix_ones[n] - prefix_ones[i]);
            res = res.min(flips);
        }
        res
    }
}