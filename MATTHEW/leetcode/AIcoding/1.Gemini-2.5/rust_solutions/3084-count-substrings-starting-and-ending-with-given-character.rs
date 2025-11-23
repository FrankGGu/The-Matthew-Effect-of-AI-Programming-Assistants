impl Solution {
    pub fn count_substrings(s: String, c: char) -> i32 {
        let mut total_count = 0;
        let mut current_c_occurrences = 0;

        for ch in s.chars() {
            if ch == c {
                current_c_occurrences += 1;
                total_count += current_c_occurrences;
            }
        }

        total_count
    }
}