impl Solution {
    pub fn max_product(s: String) -> i64 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut max_len = vec![0; n];
        let (mut center, mut right) = (0, 0);
        let mut d1 = vec![0; n];
        for i in 0..n {
            let mut k = 1;
            if i < right {
                k = std::cmp::min(d1[2 * center - i], right - i);
            }
            while i >= k && i + k < n && s_bytes[i - k] == s_bytes[i + k] {
                k += 1;
            }
            d1[i] = k;
            if i + k > right {
                center = i;
                right = i + k;
            }
            max_len[i + k - 1] = std::cmp::max(max_len[i + k - 1], 2 * k - 1);
        }
        for i in (0..n - 1).rev() {
            max_len[i] = std::cmp::max(max_len[i], max_len[i + 1] - 2);
        }
        let mut left_max = vec![0; n];
        left_max[0] = max_len[0];
        for i in 1..n {
            left_max[i] = std::cmp::max(left_max[i - 1], max_len[i]);
        }
        let (mut center, mut right) = (0, 0);
        let mut d2 = vec![0; n];
        for i in 0..n {
            let mut k = 0;
            if i < right {
                k = std::cmp::min(d2[2 * center - i], right - i);
            }
            while i >= k + 1 && i + k < n && s_bytes[i - k - 1] == s_bytes[i + k] {
                k += 1;
            }
            d2[i] = k;
            if i + k > right {
                center = i;
                right = i + k;
            }
        }
        let mut max_product = 0;
        let mut right_max = 0;
        for i in (1..n).rev() {
            if d2[i] > 0 {
                let len = 2 * d2[i];
                right_max = std::cmp::max(right_max, len);
                if left_max[i - len] > 0 {
                    max_product = std::cmp::max(max_product, left_max[i - len] as i64 * right_max as i64);
                }
            }
        }
        max_product
    }
}