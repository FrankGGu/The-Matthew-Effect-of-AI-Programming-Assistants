impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        let n1 = s1.len();
        let n2 = s2.len();

        if n1 > n2 {
            return false;
        }

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        let mut s1_counts = [0; 26];
        let mut window_counts = [0; 26];

        for i in 0..n1 {
            s1_counts[(s1_bytes[i] - b'a') as usize] += 1;
            window_counts[(s2_bytes[i] - b'a') as usize] += 1;
        }

        let mut matches = 0;
        for i in 0..26 {
            if s1_counts[i] == window_counts[i] {
                matches += 1;
            }
        }

        if matches == 26 {
            return true;
        }

        for i in n1..n2 {
            let right_char_idx = (s2_bytes[i] - b'a') as usize;
            let left_char_idx = (s2_bytes[i - n1] - b'a') as usize;

            // Update for the character leaving the window
            if s1_counts[left_char_idx] == window_counts[left_char_idx] {
                matches -= 1;
            }
            window_counts[left_char_idx] -= 1;
            if s1_counts[left_char_idx] == window_counts[left_char_idx] {
                matches += 1;
            }

            // Update for the character entering the window
            if s1_counts[right_char_idx] == window_counts[right_char_idx] {
                matches -= 1;
            }
            window_counts[right_char_idx] += 1;
            if s1_counts[right_char_idx] == window_counts[right_char_idx] {
                matches += 1;
            }

            if matches == 26 {
                return true;
            }
        }

        false
    }
}