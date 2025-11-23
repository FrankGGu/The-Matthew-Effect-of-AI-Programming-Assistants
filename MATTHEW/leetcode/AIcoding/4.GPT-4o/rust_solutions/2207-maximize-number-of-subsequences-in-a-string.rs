struct Solution;

impl Solution {
    pub fn maximum_subsequence_count(text: String, pattern: String) -> i64 {
        let (a, b) = (pattern.chars().nth(0).unwrap(), pattern.chars().nth(1).unwrap());
        let mut count_a = 0;
        let mut count_b = 0;
        let mut total = 0;

        for ch in text.chars() {
            if ch == b {
                total += count_a;
                count_b += 1;
            }
            if ch == a {
                count_a += 1;
            }
        }

        total + count_a.max(count_b)
    }
}