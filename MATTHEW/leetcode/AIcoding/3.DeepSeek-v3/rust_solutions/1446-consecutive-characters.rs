impl Solution {
    pub fn max_power(s: String) -> i32 {
        let mut max = 1;
        let mut current = 1;
        let chars: Vec<char> = s.chars().collect();

        for i in 1..chars.len() {
            if chars[i] == chars[i - 1] {
                current += 1;
                if current > max {
                    max = current;
                }
            } else {
                current = 1;
            }
        }

        max
    }
}