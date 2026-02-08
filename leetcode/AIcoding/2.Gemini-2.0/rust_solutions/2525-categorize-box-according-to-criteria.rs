impl Solution {
    pub fn categorize_box(length: i32, width: i32, height: i32, mass: i32) -> String {
        let volume = length as i64 * width as i64 * height as i64;
        let bulky = length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000;
        let heavy = mass >= 100;

        match (bulky, heavy) {
            (true, true) => "Both".to_string(),
            (true, false) => "Bulky".to_string(),
            (false, true) => "Heavy".to_string(),
            (false, false) => "Neither".to_string(),
        }
    }
}