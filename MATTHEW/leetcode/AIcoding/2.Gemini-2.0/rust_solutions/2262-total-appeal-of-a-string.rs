impl Solution {
    pub fn total_appeal(s: String) -> i64 {
        let n = s.len();
        let s = s.as_bytes();
        let mut last_seen = vec![-1; 26];
        let mut ans = 0;
        for i in 0..n {
            let c = (s[i] - b'a') as usize;
            ans += (i as i64 - last_seen[c]) * (n as i64 - i as i64);
            last_seen[c] = i as i64;
        }
        ans
    }
}