impl Solution {
    pub fn max_power(s: String) -> i32 {
        let mut max_power = 0;
        let mut current_power = 0;
        let mut prev_char = '\0'; 

        for c in s.chars() {
            if c == prev_char {
                current_power += 1;
            } else {
                max_power = max_power.max(current_power);
                current_power = 1;
                prev_char = c;
            }
        }

        max_power = max_power.max(current_power);

        max_power
    }
}