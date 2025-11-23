impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        if s1.len() > s2.len() {
            return false;
        }

        let mut s1_counts = [0; 26];
        let mut s2_counts = [0; 26];

        for &c in s1.as_bytes() {
            s1_counts[(c - b'a') as usize] += 1;
        }

        for &c in s2.as_bytes().iter().take(s1.len()) {
            s2_counts[(c - b'a') as usize] += 1;
        }

        if s1_counts == s2_counts {
            return true;
        }

        for i in 0..(s2.len() - s1.len()) {
            s2_counts[(s2.as_bytes()[i] - b'a') as usize] -= 1;
            s2_counts[(s2.as_bytes()[i + s1.len()] - b'a') as usize] += 1;

            if s1_counts == s2_counts {
                return true;
            }
        }

        false
    }
}