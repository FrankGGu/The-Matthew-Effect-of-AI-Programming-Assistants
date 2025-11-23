struct Solution;

impl Solution {
    pub fn reverse_degree(s: String) -> i32 {
        let mut count = 0;
        let mut chars = s.chars().rev();
        while let Some(c) = chars.next() {
            if c == 'a' {
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}