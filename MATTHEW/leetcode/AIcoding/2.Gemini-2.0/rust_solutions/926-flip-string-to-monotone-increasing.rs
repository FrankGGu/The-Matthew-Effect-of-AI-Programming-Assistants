impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let mut ones = 0;
        let mut flips = 0;
        for c in s.chars() {
            if c == '1' {
                ones += 1;
            } else {
                flips += 1;
            }
            flips = flips.min(ones);
        }
        flips
    }
}