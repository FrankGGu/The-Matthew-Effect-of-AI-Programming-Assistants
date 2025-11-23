use std::f64::consts::PI;

impl Solution {
    pub fn max_visible_points(points: Vec<Vec<i32>>, angle: i32, location: Vec<i32>) -> i32 {
        let loc_x = location[0] as f64;
        let loc_y = location[1] as f64;

        let mut angles: Vec<f64> = Vec::new();
        let mut origin_points = 0;

        for point in points {
            let px = point[0] as f64;
            let py = point[1] as f64;

            if px == loc_x && py == loc_y {
                origin_points += 1;
            } else {
                // Calculate angle using atan2. Result is in [-PI, PI].
                let mut angle_rad = (py - loc_y).atan2(px - loc_x);
                // Normalize to [0, 2PI)
                if angle_rad < 0.0 {
                    angle_rad += 2.0 * PI;
                }
                angles.push(angle_rad);
            }
        }

        angles.sort_by(|a, b| a.partial_cmp(b).unwrap());

        let n = angles.len();

        // If there are no non-origin points, only origin points are visible.
        if n == 0 {
            return origin_points;
        }

        // Duplicate angles for circular window handling.
        // We add 2PI to each angle in the original list to handle cases
        // where the field of view wraps around the 0/2PI boundary.
        let mut extended_angles = Vec::with_capacity(2 * n);
        for &a in angles.iter() {
            extended_angles.push(a);
        }
        for &a in angles.iter() {
            extended_angles.push(a + 2.0 * PI);
        }

        let angle_limit_rad = (angle as f64) * PI / 180.0;

        let mut max_visible_non_origin = 0;

        // If the angle is 360 degrees or more, all non-origin points are visible.
        if angle_limit_rad >= 2.0 * PI {
            max_visible_non_origin = n;
        } else {
            let mut left = 0;
            for right in 0..extended_angles.len() {
                // Shrink window from the left if it exceeds the angle limit
                while extended_angles[right] - extended_angles[left] > angle_limit_rad {
                    left += 1;
                }
                // Update max visible points in the current window
                max_visible_non_origin = max_visible_non_origin.max(right - left + 1);
            }
        }

        max_visible_non_origin as i32 + origin_points
    }
}