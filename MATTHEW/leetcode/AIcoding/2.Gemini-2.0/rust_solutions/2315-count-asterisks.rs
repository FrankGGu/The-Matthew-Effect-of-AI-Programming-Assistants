impl Solution {
    pub fn count_asterisks(s: String) -> i32 {
        let mut count = 0;
        let mut in_pair = false;
        for c in s.chars() {
            if c == '*' && !in_pair {
                count += 1;
            } else if c == '|' {
                in_pair = !in_pair;
            }
        }
        count
    }
}