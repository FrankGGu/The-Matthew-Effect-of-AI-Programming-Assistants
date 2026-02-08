impl Solution {
    pub fn is_sum_equal(first_word: String, second_word: String, target_word: String) -> bool {
        fn word_to_value(word: String) -> i32 {
            let mut value = 0;
            for c in word.chars() {
                value = value * 10 + (c as u8 - b'a') as i32;
            }
            value
        }

        let val1 = word_to_value(first_word);
        let val2 = word_to_value(second_word);
        let val3 = word_to_value(target_word);

        val1 + val2 == val3
    }
}