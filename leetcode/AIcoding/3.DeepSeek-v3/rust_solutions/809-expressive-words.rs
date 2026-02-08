impl Solution {
    pub fn expressive_words(s: String, words: Vec<String>) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let s_groups = Self::group_chars(&s_chars);

        words.iter().filter(|word| {
            let word_chars: Vec<char> = word.chars().collect();
            let word_groups = Self::group_chars(&word_chars);

            if s_groups.len() != word_groups.len() {
                return false;
            }

            for i in 0..s_groups.len() {
                let (s_char, s_count) = s_groups[i];
                let (word_char, word_count) = word_groups[i];

                if s_char != word_char {
                    return false;
                }

                if s_count < word_count {
                    return false;
                }

                if s_count < 3 && s_count != word_count {
                    return false;
                }
            }

            true
        }).count() as i32
    }

    fn group_chars(chars: &[char]) -> Vec<(char, usize)> {
        let mut groups = Vec::new();
        if chars.is_empty() {
            return groups;
        }

        let mut current_char = chars[0];
        let mut count = 1;

        for &c in &chars[1..] {
            if c == current_char {
                count += 1;
            } else {
                groups.push((current_char, count));
                current_char = c;
                count = 1;
            }
        }
        groups.push((current_char, count));
        groups
    }
}