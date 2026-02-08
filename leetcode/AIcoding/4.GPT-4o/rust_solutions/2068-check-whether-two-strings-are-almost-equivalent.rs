impl Solution {
    pub fn are_almost_equivalent(s1: String, s2: String) -> bool {
        let mut count = [0; 26];

        for c in s1.chars() {
            count[(c as usize - 'a' as usize)] += 1;
        }

        for c in s2.chars() {
            count[(c as usize - 'a' as usize)] -= 1;
        }

        let mut diff = 0;
        for &c in &count {
            if c != 0 {
                diff += c.abs();
            }
        }

        diff <= 2
    }
}