impl Solution {
    pub fn max_product(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut max_len = vec![0; n];
        let mut max_len_rev = vec![0; n];

        for i in 0..n {
            let mut l = i;
            let mut r = i;
            while l >= 0 && r < n && s_bytes[l] == s_bytes[r] {
                max_len[r] = std::cmp::max(max_len[r], (r - l + 1) as i32);
                if l > 0 {
                    max_len[r] = std::cmp::max(max_len[r], max_len[r - 1]);
                }
                l -= 1;
                r += 1;
            }

            l = i;
            r = i + 1;
            while l >= 0 && r < n && s_bytes[l] == s_bytes[r] {
                max_len[r] = std::cmp::max(max_len[r], (r - l + 1) as i32);
                if l > 0 {
                    max_len[r] = std::cmp::max(max_len[r], max_len[r - 1]);
                }
                l -= 1;
                r += 1;
            }

             if i > 0 {
                max_len[i] = std::cmp::max(max_len[i], max_len[i - 1]);
            }
        }

        for i in (0..n).rev() {
            let mut l = i;
            let mut r = i;
            while l >= 0 && r < n && s_bytes[l] == s_bytes[r] {
                max_len_rev[l] = std::cmp::max(max_len_rev[l], (r - l + 1) as i32);
                if r < n - 1 {
                    max_len_rev[l] = std::cmp::max(max_len_rev[l], max_len_rev[l + 1]);
                }
                l -= 1;
                r += 1;
            }

            l = i - 1;
            r = i;
            while l >= 0 && r < n && s_bytes[l] == s_bytes[r] {
                max_len_rev[l] = std::cmp::max(max_len_rev[l], (r - l + 1) as i32);
                if r < n - 1 {
                    max_len_rev[l] = std::cmp::max(max_len_rev[l], max_len_rev[l + 1]);
                }
                l -= 1;
                r += 1;
            }

            if i < n - 1 {
                max_len_rev[i] = std::cmp::max(max_len_rev[i], max_len_rev[i + 1]);
            }
        }

        let mut max_prod = 0;
        for i in 0..n - 1 {
            max_prod = std::cmp::max(max_prod, max_len[i] * max_len_rev[i + 1]);
        }

        max_prod
    }
}