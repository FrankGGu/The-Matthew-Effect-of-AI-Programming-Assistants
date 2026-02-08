impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut s_counts = [0; 26];
        let mut t_counts = [0; 26];

        for &byte in s.as_bytes() {
            s_counts[(byte - b'a') as usize] += 1;
        }

        for &byte in t.as_bytes() {
            t_counts[(byte - b'a') as usize] += 1;
        }

        let mut steps = 0;
        for i in 0..26 {
            if s_counts[i] > t_counts[i] {
                steps += s_counts[i] - t_counts[i];
            }
        }

        steps
    }
}