impl Solution {
    pub fn num_sub(s: String) -> i32 {
        let mut res = 0;
        let mut count = 0;
        let modulo = 1_000_000_007;

        for c in s.chars() {
            if c == '1' {
                count += 1;
                res = (res + count) % modulo;
            } else {
                count = 0;
            }
        }

        res
    }
}