struct Solution;

impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let mut flip = 0;
        let mut count = 0;
        for c in s.chars() {
            if c == '1' {
                count += 1;
            } else {
                flip += 1;
            }
            flip = flip.min(count);
        }
        flip
    }
}