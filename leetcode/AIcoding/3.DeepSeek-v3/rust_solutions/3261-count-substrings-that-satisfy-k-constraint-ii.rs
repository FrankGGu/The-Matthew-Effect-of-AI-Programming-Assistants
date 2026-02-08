impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i64 {
        let s = s.as_bytes();
        let n = s.len();
        let mut res = 0i64;
        let mut freq = [0; 26];
        let mut left = 0;

        for right in 0..n {
            freq[(s[right] - b'a') as usize] += 1;
            while freq.iter().filter(|&&count| count > 0).max().unwrap_or(&0) >= k {
                freq[(s[left] - b'a') as usize] -= 1;
                left += 1;
            }
            res += (right - left + 1) as i64;
        }

        let total = (n * (n + 1) / 2) as i64;
        total - res
    }
}