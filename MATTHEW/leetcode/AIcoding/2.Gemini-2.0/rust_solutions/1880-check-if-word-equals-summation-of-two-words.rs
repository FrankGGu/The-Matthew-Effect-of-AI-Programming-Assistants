impl Solution {
    pub fn is_sum_equal(first_word: String, second_word: String, target_word: String) -> bool {
        let first = Self::convert_to_num(first_word);
        let second = Self::convert_to_num(second_word);
        let target = Self::convert_to_num(target_word);

        first + second == target
    }

    fn convert_to_num(word: String) -> i32 {
        let mut num = 0;
        for c in word.chars() {
            num = num * 10 + (c as i32 - 'a' as i32);
        }
        num
    }
}