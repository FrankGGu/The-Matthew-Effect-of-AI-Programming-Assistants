impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut res = 0;

        for i in 0..n {
            let mut freq = [0; 26];
            for j in i..n {
                freq[(s[j] - b'a') as usize] += 1;
                if freq.iter().any(|&count| count == k) {
                    res += 1;
                }
            }
        }

        res
    }
}