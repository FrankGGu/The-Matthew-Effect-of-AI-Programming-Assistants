const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn count_substrings(s: String, t: String, k: i32) -> i32 {
        let n = s.len();
        let m = t.len();
        let k = k as usize;
        let s: Vec<char> = s.chars().collect();
        let t: Vec<char> = t.chars().collect();

        let mut ans = 0;

        for i in 0..n {
            for j in 0..m {
                let mut diff = 0;
                let mut l = 0;
                while i + l < n && j + l < m {
                    if s[i + l] != t[j + l] {
                        diff += 1;
                    }
                    if diff <= k {
                        ans += 1;
                    } else {
                        break;
                    }
                    l += 1;
                }
            }
        }

        ans
    }
}