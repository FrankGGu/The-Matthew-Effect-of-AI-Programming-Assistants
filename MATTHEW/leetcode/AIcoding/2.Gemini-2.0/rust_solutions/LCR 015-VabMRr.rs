impl Solution {
    pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
        let s_bytes = s.as_bytes();
        let p_bytes = p.as_bytes();
        let n = s.len();
        let m = p.len();

        if m > n {
            return vec![];
        }

        let mut p_freq = [0; 26];
        let mut s_freq = [0; 26];

        for i in 0..m {
            p_freq[(p_bytes[i] - b'a') as usize] += 1;
            s_freq[(s_bytes[i] - b'a') as usize] += 1;
        }

        let mut result = vec![];
        if p_freq == s_freq {
            result.push(0);
        }

        for i in 1..=n - m {
            s_freq[(s_bytes[i - 1] - b'a') as usize] -= 1;
            s_freq[(s_bytes[i + m - 1] - b'a') as usize] += 1;

            if p_freq == s_freq {
                result.push(i as i32);
            }
        }

        result
    }
}