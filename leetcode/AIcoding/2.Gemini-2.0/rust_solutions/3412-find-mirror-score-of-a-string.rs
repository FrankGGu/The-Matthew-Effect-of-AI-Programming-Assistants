impl Solution {
    pub fn find_mirror_score(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s: Vec<char> = s.chars().collect();
        let mut ans = 0;

        for i in 0..n {
            let mut l = i;
            let mut r = i;
            let mut len = 1;

            while l > 0 && r < n - 1 && s[l - 1] == s[r + 1] && len < k {
                l -= 1;
                r += 1;
                len += 1;
            }

            if len == k {
                ans += 1;
            }
        }

        for i in 0..n - 1 {
            let mut l = i;
            let mut r = i + 1;
            let mut len = 0;

            if s[l] == s[r] {
                len = 1;
                while l > 0 && r < n - 1 && s[l - 1] == s[r + 1] && len < k {
                    l -= 1;
                    r += 1;
                    len += 1;
                }

                if len == k {
                    ans += 1;
                }
            }
        }

        ans
    }
}