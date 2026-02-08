impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        let n1 = s1.len();
        let n2 = s2.len();

        if n1 > n2 {
            return false;
        }

        let mut s1_freq = [0; 26];
        for c in s1.chars() {
            s1_freq[(c as u8 - b'a') as usize] += 1;
        }

        let mut window_freq = [0; 26];
        let s2_bytes = s2.as_bytes();

        for i in 0..n1 {
            window_freq[(s2_bytes[i] - b'a') as usize] += 1;
        }

        if window_freq == s1_freq {
            return true;
        }

        for i in n1..n2 {
            window_freq[(s2_bytes[i - n1] - b'a') as usize] -= 1;
            window_freq[(s2_bytes[i] - b'a') as usize] += 1;

            if window_freq == s1_freq {
                return true;
            }
        }

        false
    }
}