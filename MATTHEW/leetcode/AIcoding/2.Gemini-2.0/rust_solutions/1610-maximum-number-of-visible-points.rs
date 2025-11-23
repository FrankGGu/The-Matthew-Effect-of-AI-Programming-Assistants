use std::f64::consts::PI;

impl Solution {
    pub fn max_number_of_visible_points(points: Vec<Vec<i32>>, angle: i32, location: Vec<i32>) -> i32 {
        let mut angles: Vec<f64> = Vec::new();
        for point in &points {
            let dx = point[0] - location[0];
            let dy = point[1] - location[1];
            if dx == 0 && dy == 0 {
                continue;
            }
            let mut ang = (dy as f64).atan2(dx as f64);
            if ang < 0.0 {
                ang += 2.0 * PI;
            }
            angles.push(ang);
        }
        angles.sort_by(|a, b| a.partial_cmp(b).unwrap());

        let mut extended_angles = angles.clone();
        for &ang in &angles {
            extended_angles.push(ang + 2.0 * PI);
        }

        let mut max_visible = 0;
        let mut left = 0;
        let angle_rad = (angle as f64) * PI / 180.0;

        for right in 0..extended_angles.len() {
            while extended_angles[right] - extended_angles[left] > angle_rad {
                left += 1;
            }
            max_visible = max_visible.max(right - left + 1);
        }

        let same_location = points.iter().filter(|p| p[0] == location[0] && p[1] == location[1]).count() as i32;
        max_visible + same_location
    }
}