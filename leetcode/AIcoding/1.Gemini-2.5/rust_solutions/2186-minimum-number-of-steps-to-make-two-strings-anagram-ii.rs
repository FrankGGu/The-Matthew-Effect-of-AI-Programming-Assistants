impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut freq_s = [0; 26];
        let mut freq_t = [0; 26];

        for c in s.bytes() {
            freq_s[(c - b'a') as usize] += 1;
        }

        for c in t.bytes() {
            freq_t[(c - b'a') as usize] += 1;
        }

        let mut steps = 0;
        for i in 0..26 {
            steps += (freq_s[i] - freq_t[i]).abs();
        }

        steps
    }
}