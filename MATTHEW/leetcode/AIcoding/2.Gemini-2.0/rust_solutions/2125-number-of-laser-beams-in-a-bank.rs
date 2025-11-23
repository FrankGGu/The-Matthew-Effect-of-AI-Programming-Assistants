impl Solution {
    pub fn number_of_laser_beams(bank: Vec<String>) -> i32 {
        let mut prev_devices = 0;
        let mut total_beams = 0;

        for row in bank {
            let current_devices = row.chars().filter(|&c| c == '1').count() as i32;

            if current_devices > 0 {
                total_beams += prev_devices * current_devices;
                prev_devices = current_devices;
            }
        }

        total_beams
    }
}