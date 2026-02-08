impl Solution {
    pub fn is_sum_equal(first_word: String, second_word: String, target_word: String) -> bool {
        let to_num = |word: String| -> i32 {
            word.chars()
                .map(|c| (c as u8 - b'a') as i32)
                .fold(0, |acc, x| acc * 10 + x)
        };

        let first_num = to_num(first_word);
        let second_num = to_num(second_word);
        let target_num = to_num(target_word);

        first_num + second_num == target_num
    }
}