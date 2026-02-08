impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut freq = [0; 26];

        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        for c in t.chars() {
            freq[(c as u8 - b'a') as usize] -= 1;
        }

        let mut steps = 0;
        for val in freq.iter() {
            steps += val.abs();
        }

        steps / 2
    }
}