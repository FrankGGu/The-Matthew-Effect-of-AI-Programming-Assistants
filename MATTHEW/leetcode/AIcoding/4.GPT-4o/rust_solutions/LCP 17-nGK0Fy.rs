impl Solution {
    pub fn calculate_time(keyboard: String, word: String) -> i32 {
        let mut keyboard_map = vec![0; 26];
        for (i, c) in keyboard.chars().enumerate() {
            keyboard_map[(c as u8 - b'a') as usize] = i as i32;
        }

        let mut total_time = 0;
        let mut current_pos = 0;

        for c in word.chars() {
            let target_pos = keyboard_map[(c as u8 - b'a') as usize];
            total_time += (target_pos - current_pos).abs();
            current_pos = target_pos;
        }

        total_time
    }
}