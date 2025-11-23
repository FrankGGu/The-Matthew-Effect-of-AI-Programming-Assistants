impl Solution {
    pub fn minimum_deletions(s: String) -> i32 {
        let mut count_a = 0;
        let mut count_b = 0;

        for ch in s.chars().rev() {
            if ch == 'a' {
                count_a += 1;
            } else {
                count_b += 1;
            }
            if count_b > count_a {
                count_b -= 1;
            }
        }

        count_b
    }
}