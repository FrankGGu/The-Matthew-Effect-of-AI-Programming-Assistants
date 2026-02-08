impl Solution {
    pub fn min_cost(colors: String, needed_time: Vec<i32>) -> i32 {
        let n = colors.len();
        if n <= 1 {
            return 0;
        }

        let chars_bytes = colors.as_bytes();
        let mut total_time_removed = 0;

        let mut current_group_max_time = needed_time[0];
        let mut current_group_sum_time = needed_time[0];
        let mut previous_char_byte = chars_bytes[0];

        for i in 1..n {
            let current_char_byte = chars_bytes[i];
            let current_time = needed_time[i];

            if current_char_byte == previous_char_byte {
                current_group_sum_time += current_time;
                current_group_max_time = current_group_max_time.max(current_time);
            } else {
                total_time_removed += current_group_sum_time - current_group_max_time;

                current_group_sum_time = current_time;
                current_group_max_time = current_time;
                previous_char_byte = current_char_byte;
            }
        }

        total_time_removed += current_group_sum_time - current_group_max_time;

        total_time_removed
    }
}