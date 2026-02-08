impl Solution {
    pub fn minimum_steps(s: String) -> i64 {
        let mut steps = 0;
        let mut black_count = 0;
        for c in s.chars() {
            if c == '1' {
                black_count += 1;
            } else {
                steps += black_count;
            }
        }
        steps
    }
}