impl Solution {
    pub fn reorder_spaces(text: String) -> String {
        let total_spaces = text.chars().filter(|&c| c == ' ').count();
        let words: Vec<&str> = text.split_whitespace().collect();
        let num_words = words.len();

        if num_words == 1 {
            return format!("{}{}", words[0], " ".repeat(total_spaces));
        }

        let num_gaps = num_words - 1;
        let spaces_per_gap = total_spaces / num_gaps;
        let extra_spaces_at_end = total_spaces % num_gaps;

        let gap_string = " ".repeat(spaces_per_gap);
        let extra_string = " ".repeat(extra_spaces_at_end);

        let mut result = words.join(&gap_string);
        result.push_str(&extra_string);

        result
    }
}