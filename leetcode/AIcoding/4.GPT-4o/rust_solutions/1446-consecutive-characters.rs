impl Solution {
    pub fn max_power(s: String) -> i32 {
        let mut max_power = 1;
        let mut current_power = 1;

        for i in 1..s.len() {
            if s.as_bytes()[i] == s.as_bytes()[i - 1] {
                current_power += 1;
            } else {
                max_power = max_power.max(current_power);
                current_power = 1;
            }
        }

        max_power.max(current_power)
    }
}