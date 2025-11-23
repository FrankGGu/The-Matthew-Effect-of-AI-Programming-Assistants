struct Solution;

impl Solution {
    pub fn reorder_spaces(mut words: Vec<String>, mut length: i32) -> String {
        let word_count = words.len();
        if word_count == 1 {
            return words[0].clone() + &" ".repeat(length as usize);
        }

        let total_spaces = length;
        let mut space_count = 0;
        for word in &words {
            space_count += word.len() as i32;
        }
        let spaces_needed = total_spaces - space_count;

        let mut result = String::new();
        let space_per_gap = spaces_needed / (word_count as i32 - 1);
        let extra_spaces = spaces_needed % (word_count as i32 - 1);

        for (i, word) in words.iter().enumerate() {
            result.push_str(word);
            if i < word_count - 1 {
                result.push_str(&" ".repeat(space_per_gap as usize));
                if extra_spaces > 0 {
                    result.push(' ');
                    extra_spaces -= 1;
                }
            }
        }

        result
    }
}