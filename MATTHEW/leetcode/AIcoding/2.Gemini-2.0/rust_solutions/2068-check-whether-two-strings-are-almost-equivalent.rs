impl Solution {
    pub fn check_if_almost_equal(s1: String, s2: String) -> bool {
        let mut freq1 = [0; 26];
        let mut freq2 = [0; 26];

        for &b in s1.as_bytes() {
            freq1[(b - b'a') as usize] += 1;
        }

        for &b in s2.as_bytes() {
            freq2[(b - b'a') as usize] += 1;
        }

        for i in 0..26 {
            if (freq1[i] - freq2[i]).abs() > 3 {
                return false;
            }
        }

        true
    }
}