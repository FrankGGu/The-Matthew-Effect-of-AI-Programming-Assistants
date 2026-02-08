impl Solution {
    pub fn unit_conversion(value: f64, unit: String) -> f64 {
        if unit == "m".to_string() {
            value * 1000.0
        } else if unit == "kg".to_string() {
            value * 2.205
        } else if unit == "km".to_string() {
            value * 100000.0
        } else {
            value / 2.205
        }
    }
}