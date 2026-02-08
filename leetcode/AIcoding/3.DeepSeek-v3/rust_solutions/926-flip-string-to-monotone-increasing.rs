impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let s = s.as_bytes();
        let mut flip_count = 0;
        let mut ones_count = 0;

        for &c in s {
            if c == b'1' {
                ones_count += 1;
            } else {
                flip_count = std::cmp::min(flip_count + 1, ones_count);
            }
        }

        flip_count
    }
}