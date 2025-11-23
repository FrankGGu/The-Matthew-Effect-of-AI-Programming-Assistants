impl Solution {
    pub fn min_time_to_type(word: String) -> i32 {
        let mut total_time = 0;
        let mut current_char = 'a';

        for target_char in word.chars() {
            let diff = (current_char as i32 - target_char as i32).abs();
            let move_time = diff.min(26 - diff);

            total_time += move_time;
            total_time += 1; // 1 second to type the character

            current_char = target_char;
        }

        total_time
    }
}