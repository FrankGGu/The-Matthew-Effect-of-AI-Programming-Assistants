impl Solution {
    pub fn count_asterisks(s: String) -> i32 {
        let mut count = 0;
        let mut in_bar = false;

        for ch in s.chars() {
            if ch == '|' {
                in_bar = !in_bar;
            } else if ch == '*' && !in_bar {
                count += 1;
            }
        }

        count
    }
}