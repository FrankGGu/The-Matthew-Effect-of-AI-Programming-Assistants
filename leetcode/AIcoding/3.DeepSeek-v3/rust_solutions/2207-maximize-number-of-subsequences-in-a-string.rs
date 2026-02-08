impl Solution {
    pub fn maximum_subsequence_count(text: String, pattern: String) -> i64 {
        let (a, b) = (pattern.chars().nth(0).unwrap(), pattern.chars().nth(1).unwrap());
        let mut count_a = 0;
        let mut count_b = 0;
        let mut res = 0;

        for c in text.chars() {
            if c == b {
                res += count_a;
                count_b += 1;
            }
            if c == a {
                count_a += 1;
            }
        }

        res + std::cmp::max(count_a, count_b)
    }
}