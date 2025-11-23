impl Solution {
    pub fn angle_clock(hour: i32, minutes: i32) -> f64 {
        let hour_f = hour as f64;
        let minutes_f = minutes as f64;

        // Angle of the minute hand from 12 o'clock
        // 360 degrees in 60 minutes = 6 degrees per minute
        let minute_angle = minutes_f * 6.0;

        // Angle of the hour hand from 12 o'clock
        // 360 degrees in 12 hours = 30 degrees per hour
        // Also, it moves 0.5 degrees per minute (30/60)
        let hour_angle = (hour_f % 12.0 + minutes_f / 60.0) * 30.0;

        // Calculate the absolute difference between the angles
        let mut diff = (hour_angle - minute_angle).abs();

        // The angle can be measured clockwise or counter-clockwise.
        // We need the smaller of the two angles.
        // If diff > 180, then the smaller angle is 360 - diff.
        diff.min(360.0 - diff)
    }
}