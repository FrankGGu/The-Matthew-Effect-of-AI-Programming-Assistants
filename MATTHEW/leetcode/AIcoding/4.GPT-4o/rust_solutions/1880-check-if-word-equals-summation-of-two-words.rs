impl Solution {
    pub fn is_sum_equal(first_word: String, second_word: String, target_word: String) -> bool {
        fn word_to_number(word: &str) -> i32 {
            word.chars().fold(0, |acc, c| acc * 10 + (c as i32 - 'a' as i32))
        }
        word_to_number(&first_word) + word_to_number(&second_word) == word_to_number(&target_word)
    }
}