impl Solution {
    pub fn longest_push_time(buttons: Vec<i32>) -> i32 {
        let mut max_time = 0;
        let mut current_time = 0;

        for &button in &buttons {
            current_time += button;
            max_time = max_time.max(current_time);
        }

        max_time
    }
}