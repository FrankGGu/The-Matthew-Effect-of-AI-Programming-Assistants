impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut s_counts = [0; 26];
        let mut t_counts = [0; 26];

        for c in s.chars() {
            s_counts[(c as u8 - b'a') as usize] += 1;
        }

        for c in t.chars() {
            t_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut steps = 0;
        for i in 0..26 {
            steps += (s_counts[i] - t_counts[i]).abs();
        }

        steps
    }
}