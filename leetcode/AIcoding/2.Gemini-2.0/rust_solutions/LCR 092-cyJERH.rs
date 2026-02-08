impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut ones = 0;
        let mut flips = 0;

        for i in 0..n {
            if s[i] == '1' {
                ones += 1;
            } else {
                flips += 1;
            }
            flips = flips.min(ones);
        }
        flips
    }
}