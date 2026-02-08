impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let mut open_count = 0;
        let mut unmatched_closing_brackets = 0;

        for c in s.chars() {
            if c == '[' {
                open_count += 1;
            } else { // c == ']'
                if open_count > 0 {
                    open_count -= 1;
                } else {
                    unmatched_closing_brackets += 1;
                }
            }
        }

        (unmatched_closing_brackets + 1) / 2
    }
}