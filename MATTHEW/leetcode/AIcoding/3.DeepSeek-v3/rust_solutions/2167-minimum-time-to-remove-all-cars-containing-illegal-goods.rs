impl Solution {
    pub fn minimum_time(s: String) -> i32 {
        let n = s.len();
        let mut left = vec![0; n + 1];
        let mut right = vec![0; n + 1];
        let chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            left[i + 1] = if chars[i] == '1' {
                (left[i] + 2).min(i as i32 + 1)
            } else {
                left[i]
            };
        }

        for i in (0..n).rev() {
            right[i] = if chars[i] == '1' {
                (right[i + 1] + 2).min((n - i) as i32)
            } else {
                right[i + 1]
            };
        }

        let mut res = i32::MAX;
        for i in 0..=n {
            res = res.min(left[i] + right[i]);
        }

        res
    }
}