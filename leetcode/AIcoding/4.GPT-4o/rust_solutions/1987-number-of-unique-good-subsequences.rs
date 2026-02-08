impl Solution {
    pub fn count_good_subsequences(s: String) -> i32 {
        let mut seen = std::collections::HashSet::new();
        let mut has_zero = false;
        let mut count = 0;

        for c in s.chars() {
            if c == '0' {
                has_zero = true;
            } else {
                if seen.insert(c) {
                    count += 1;
                }
            }
        }

        let mut result = count + if has_zero { 1 } else { 0 };
        result += (1 << count) - 1;
        result as i32
    }
}