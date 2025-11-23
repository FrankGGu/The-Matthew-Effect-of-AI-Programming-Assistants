impl Solution {
    pub fn angle_between_hands(hour: i32, minutes: i32) -> f64 {
        let hour_angle = (hour % 12) as f64 * 30.0 + (minutes as f64 / 60.0) * 30.0;
        let minute_angle = (minutes as f64) * 6.0;
        let angle = (hour_angle - minute_angle).abs();
        angle.min(360.0 - angle)
    }
}