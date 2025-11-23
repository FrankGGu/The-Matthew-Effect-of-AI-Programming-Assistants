impl Solution {
    pub fn categorize_box(length: i32, width: i32, height: i32, mass: i32) -> String {
        let is_bulky: bool = {
            let volume_threshold: i64 = 1_000_000_000;
            let dim_threshold: i32 = 10_000;

            let volume: i64 = length as i64 * width as i64 * height as i64;

            volume >= volume_threshold ||
            length >= dim_threshold ||
            width >= dim_threshold ||
            height >= dim_threshold
        };

        let is_heavy: bool = mass >= 100;

        match (is_bulky, is_heavy) {
            (true, true) => "Both".to_string(),
            (true, false) => "Bulky".to_string(),
            (false, true) => "Heavy".to_string(),
            (false, false) => "Neither".to_string(),
        }
    }
}