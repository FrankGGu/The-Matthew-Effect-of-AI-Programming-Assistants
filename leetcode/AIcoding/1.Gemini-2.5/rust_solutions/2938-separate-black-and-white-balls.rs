impl Solution {
    pub fn separate_black_and_white_balls(s: String) -> i64 {
        let mut swaps: i64 = 0;
        let mut count_ones: i64 = 0;

        for c in s.chars() {
            if c == '1' {
                count_ones += 1;
            } else { // c == '0'
                swaps += count_ones;
            }
        }
        swaps
    }
}