impl Solution {
    pub fn longest_pressed_time(buttons: Vec<i32>) -> i32 {
        if buttons.is_empty() {
            return 0;
        }
        let mut max_time = 1;
        let mut current_time = 1;
        for i in 1..buttons.len() {
            if buttons[i] == buttons[i - 1] {
                current_time += 1;
                max_time = max_time.max(current_time);
            } else {
                current_time = 1;
            }
        }
        max_time
    }
}