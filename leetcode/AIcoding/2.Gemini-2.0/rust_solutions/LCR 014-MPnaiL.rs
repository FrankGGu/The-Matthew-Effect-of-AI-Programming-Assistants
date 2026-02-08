impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        if s1.len() > s2.len() {
            return false;
        }

        let s1_len = s1.len();
        let s2_len = s2.len();

        let mut s1_counts = [0; 26];
        for &c in s1.as_bytes() {
            s1_counts[(c - b'a') as usize] += 1;
        }

        let mut s2_counts = [0; 26];
        for i in 0..s1_len {
            s2_counts[(s2.as_bytes()[i] - b'a') as usize] += 1;
        }

        if s1_counts == s2_counts {
            return true;
        }

        for i in s1_len..s2_len {
            s2_counts[(s2.as_bytes()[i] - b'a') as usize] += 1;
            s2_counts[(s2.as_bytes()[i - s1_len] - b'a') as usize] -= 1;
            if s1_counts == s2_counts {
                return true;
            }
        }

        false
    }
}