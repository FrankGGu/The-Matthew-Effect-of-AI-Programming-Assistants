impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut res = 0;

        for i in 0..n {
            let mut freq = [0; 26];
            let mut distinct = 0;

            for j in i..n {
                let idx = (s[j] - b'a') as usize;
                if freq[idx] == 0 {
                    distinct += 1;
                }
                freq[idx] += 1;

                if distinct >= k {
                    res += 1;
                }
            }
        }

        res
    }
}