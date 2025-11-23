impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut x = 1;
        let mut y = 0;
        for c in s.chars() {
            if c == 'A' {
                x = 2 * x + y;
            } else {
                y = 2 * y + x;
            }
        }
        x + y
    }
}