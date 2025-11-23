impl Solution {
    pub fn number_of_full_rounds(start_time: String, end_time: String) -> i32 {
        let start_h = start_time[0..2].parse::<i32>().unwrap();
        let start_m = start_time[3..5].parse::<i32>().unwrap();
        let mut start_total_minutes = start_h * 60 + start_m;

        let end_h = end_time[0..2].parse::<i32>().unwrap();
        let end_m = end_time[3..5].parse::<i32>().unwrap();
        let mut end_total_minutes = end_h * 60 + end_m;

        if end_total_minutes < start_total_minutes {
            end_total_minutes += 24 * 60;
        }

        if start_total_minutes % 15 != 0 {
            start_total_minutes += 15 - (start_total_minutes % 15);
        }

        end_total_minutes -= end_total_minutes % 15;

        if end_total_minutes <= start_total_minutes {
            0
        } else {
            (end_total_minutes - start_total_minutes) / 15
        }
    }
}