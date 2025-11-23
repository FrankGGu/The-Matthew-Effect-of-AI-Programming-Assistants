impl Solution {
    pub fn highest_altitude(gain: Vec<i32>) -> i32 {
        let mut altitude = 0;
        let mut max_altitude = 0;
        for g in gain {
            altitude += g;
            max_altitude = max_altitude.max(altitude);
        }
        max_altitude
    }
}