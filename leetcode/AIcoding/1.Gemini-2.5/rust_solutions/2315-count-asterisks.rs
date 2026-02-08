impl Solution {
    pub fn count_asterisks(s: String) -> i32 {
        let mut count = 0;
        let mut in_bars = false;

        for c in s.chars() {
            if c == '|' {
                in_bars = !in_bars;
            } else if c == '*' {
                if !in_bars {
                    count += 1;
                }
            }
        }
        count
    }
}