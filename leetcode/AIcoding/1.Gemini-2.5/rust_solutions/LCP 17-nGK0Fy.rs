impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut x: i64 = 1;
        let modulo: i64 = 1_000_000_007;

        for op_char in s.chars() {
            if op_char == 'A' {
                x = (2 * x) % modulo;
            } else if op_char == 'B' {
                x = (x * x) % modulo;
            }
        }

        x as i32
    }
}