struct Solution;

impl Solution {
    pub fn humidity_status(humidity: i32) -> String {
        if humidity < 40 {
            "Dry".to_string()
        } else if humidity > 60 {
            "Humid".to_string()
        } else {
            "Comfortable".to_string()
        }
    }
}