impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let mut closing = 0;
        for c in s.chars() {
            if c == '[' {
                continue;
            } else {
                closing += 1;
            }
        }

        (closing + 1) / 2
    }
}