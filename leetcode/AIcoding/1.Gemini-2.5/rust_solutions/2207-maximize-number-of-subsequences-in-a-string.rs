impl Solution {
    pub fn maximize_number_of_subsequences(text: String, pattern: String) -> i64 {
        let p0_char = pattern.chars().nth(0).unwrap();
        let p1_char = pattern.chars().nth(1).unwrap();

        let mut total_p0_count_in_text: i64 = 0;
        let mut total_p1_count_in_text: i64 = 0;
        let mut original_subsequences: i64 = 0;

        for c in text.chars() {
            if c == p1_char {
                original_subsequences += total_p0_count_in_text;
                total_p1_count_in_text += 1;
            }
            if c == p0_char {
                total_p0_count_in_text += 1;
            }
        }

        let result_add_p0_at_start = original_subsequences + total_p1_count_in_text;
        let result_add_p1_at_end = original_subsequences + total_p0_count_in_text;

        result_add_p0_at_start.max(result_add_p1_at_end)
    }
}