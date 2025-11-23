impl Solution {
    pub fn minimum_score(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s_bytes.len();
        let m = t_bytes.len();

        let mut prefix = vec![0; m + 1];
        let mut suffix = vec![0; m + 1];

        let mut j = 0;
        for i in 0..n {
            if j < m && s_bytes[i] == t_bytes[j] {
                j += 1;
            }
            prefix[j] = i + 1;
        }

        j = m - 1;
        for i in (0..n).rev() {
            if j >= 0 && s_bytes[i] == t_bytes[j] {
                j -= 1;
            }
            suffix[j + 1] = i;
        }

        let mut ans = m as i32;
        for i in 0..=m {
            let mut l = 0;
            let mut r = m;
            let mut best = m;
            while l <= r {
                let mid = l + (r - l) / 2;
                if prefix[i] == 0 && mid != m {
                    l = mid + 1;
                    continue;
                }
                if suffix[mid] == n {
                    r = mid - 1;
                    continue;
                }

                if i > 0 && prefix[i] == 0 {
                    l = mid + 1;
                    continue;
                }

                if mid < m && suffix[mid] == n {
                    r = mid - 1;
                    continue;
                }

                if i > 0 && mid < m && prefix[i] <= suffix[mid] {
                    best = mid;
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            }
            ans = ans.min((best - i) as i32);
        }

        ans
    }
}