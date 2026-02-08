impl Solution {
    pub fn number_of_laser_beams(bank: Vec<String>) -> i32 {
        let mut total_beams = 0;
        let mut prev_row_devices = 0;

        for row_str in bank {
            let current_row_devices = row_str.chars().filter(|&c| c == '1').count() as i32;

            if current_row_devices > 0 {
                if prev_row_devices > 0 {
                    total_beams += prev_row_devices * current_row_devices;
                }
                prev_row_devices = current_row_devices;
            }
        }

        total_beams
    }
}