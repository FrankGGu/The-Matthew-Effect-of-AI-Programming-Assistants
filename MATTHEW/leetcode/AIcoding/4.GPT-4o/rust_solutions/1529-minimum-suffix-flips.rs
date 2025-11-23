impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let s = s.chars().collect::<Vec<_>>();
        let mut prefix = vec![0; n + 1];
        let mut suffix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] + if s[i] == '0' { 1 } else { 0 };
            suffix[n - i - 1] = suffix[n - i] + if s[n - i - 1] == '1' { 1 } else { 0 };
        }

        let mut min_flips = std::i32::MAX;
        for i in 0..=n {
            min_flips = min_flips.min(prefix[i] + suffix[i]);
        }

        min_flips
    }
}