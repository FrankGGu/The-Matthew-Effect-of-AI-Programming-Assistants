impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let s = format!("{}{}", s, s);
        let mut prefix_sum = vec![0; 2 * n + 1];

        for i in 0..2 * n {
            prefix_sum[i + 1] = prefix_sum[i] + (s.chars().nth(i).unwrap() == '0') as i32;
        }

        let mut min_flips = i32::MAX;
        for i in 0..n {
            let flips = prefix_sum[i] + (n - (prefix_sum[i + n] - prefix_sum[i]));
            min_flips = min_flips.min(flips);
        }

        min_flips
    }
}