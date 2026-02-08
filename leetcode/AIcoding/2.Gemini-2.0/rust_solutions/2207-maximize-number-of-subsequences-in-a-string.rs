impl Solution {
    pub fn max_number_of_subsequences(text: String, pattern: String) -> i64 {
        let text_chars: Vec<char> = text.chars().collect();
        let pattern_chars: Vec<char> = pattern.chars().collect();
        let p1 = pattern_chars[0];
        let p2 = pattern_chars[1];

        let mut count1 = 0;
        let mut count2 = 0;
        let mut ans = 0;

        for &c in &text_chars {
            if c == p2 {
                ans += count1;
                count2 += 1;
            }
            if c == p1 {
                count1 += 1;
            }
        }

        ans + std::cmp::max(count1, count2)
    }
}