struct Solution;

impl Solution {
    pub fn can_be_typing(possible_keyboard: String, sentence: String) -> i32 {
        let mut keyboard_set = std::collections::HashSet::new();
        for c in possible_keyboard.chars() {
            keyboard_set.insert(c);
        }
        let mut count = 0;
        let mut current_word = String::new();
        for c in sentence.chars() {
            if c == ' ' {
                count += 1;
                current_word.clear();
            } else {
                if keyboard_set.contains(&c) {
                    current_word.push(c);
                } else {
                    current_word.clear();
                }
            }
        }
        if !current_word.is_empty() {
            count += 1;
        }
        count
    }
}