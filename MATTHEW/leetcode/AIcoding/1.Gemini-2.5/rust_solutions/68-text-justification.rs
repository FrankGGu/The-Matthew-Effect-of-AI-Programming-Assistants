impl Solution {
    pub fn full_justify(words: Vec<String>, max_width: i32) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let mut i = 0; // Current word index

        while i < words.len() {
            let mut current_line_words: Vec<&String> = Vec::new();
            let mut current_line_length_words_only = 0; // Sum of lengths of words in current_line_words
            let mut j = i; // Lookahead index for words to potentially add to the current line

            // Determine words for the current line
            while j < words.len() {
                let word_len = words[j].len() as i32;

                // Calculate length if the current word is added with a minimum of one space
                // (if it's not the first word on the line).
                // current_line_words.len() represents the number of gaps if words[j] is added.
                let potential_line_length_with_min_spaces = 
                    current_line_length_words_only + word_len + (current_line_words.len() as i32); 

                if current_line_words.is_empty() {
                    // Always add the first word to the line
                    current_line_words.push(&words[j]);
                    current_line_length_words_only += word_len;
                } else if potential_line_length_with_min_spaces <= max_width {
                    // Add word if it fits with at least one space
                    current_line_words.push(&words[j]);
                    current_line_length_words_only += word_len;
                } else {
                    // Word does not fit, break and process current_line_words
                    break;
                }
                j += 1;
            }

            let mut line = String::new();
            let num_words_in_line = current_line_words.len();
            let total_spaces_to_add = max_width - current_line_length_words_only;

            if num_words_in_line == 1 || j == words.len() {
                // Case: Single word on a line OR Last line
                // Left justify: words joined by single space, then pad remaining spaces to the right.

                for k in 0..num_words_in_line {
                    line.push_str(current_line_words[k]);
                    if k < num_words_in_line - 1 {
                        line.push(' '); // Add single space between words
                    }
                }
                // Pad remaining spaces to the right to reach max_width
                let remaining_spaces = max_width - (line.len() as i32);
                for _ in 0..remaining_spaces {
                    line.push(' ');
                }
            } else {
                // Case: Regular line (multiple words, not the last line)
                let num_gaps = num_words_in_line - 1;
                let base_spaces_per_gap = total_spaces_to_add / num_gaps as i32;
                let mut extra_spaces_leftover = total_spaces_to_add % num_gaps as i32;

                for k in 0..num_words_in_line {
                    line.push_str(current_line_words[k]);
                    if k < num_words_in_line - 1 { // If not the last word in the line
                        // Add base spaces
                        for _ in 0..base_spaces_per_gap {
                            line.push(' ');
                        }
                        // Add one extra space if available (from left to right)
                        if extra_spaces_leftover > 0 {
                            line.push(' ');
                            extra_spaces_leftover -= 1;
                        }
                    }
                }
            }
            result.push(line);
            i = j; // Move to the next word after the current line
        }
        result
    }
}