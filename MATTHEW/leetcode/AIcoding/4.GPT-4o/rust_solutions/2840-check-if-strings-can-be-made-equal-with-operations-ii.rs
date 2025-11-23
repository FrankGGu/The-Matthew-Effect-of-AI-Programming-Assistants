impl Solution {
    pub fn can_be_equal(s1: String, s2: String) -> bool {
        if s1.len() != s2.len() {
            return false;
        }
        let n = s1.len();
        let mut s1_count = vec![0; 26];
        let mut s2_count = vec![0; 26];

        for i in 0..n {
            s1_count[(s1.as_bytes()[i] - b'a') as usize] += 1;
            s2_count[(s2.as_bytes()[i] - b'a') as usize] += 1;
        }

        for i in 0..26 {
            if s1_count[i] % 2 != s2_count[i] % 2 {
                return false;
            }
        }
        true
    }
}