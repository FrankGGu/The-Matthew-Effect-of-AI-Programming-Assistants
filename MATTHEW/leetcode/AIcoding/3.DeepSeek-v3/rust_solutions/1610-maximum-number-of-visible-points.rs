use std::f64::consts::PI;

impl Solution {
    pub fn visible_points(points: Vec<Vec<i32>>, angle: i32, location: Vec<i32>) -> i32 {
        let mut angles = Vec::new();
        let mut same = 0;
        let (x, y) = (location[0], location[1]);
        let angle = angle as f64;

        for point in points {
            let (px, py) = (point[0], point[1]);
            if px == x && py == y {
                same += 1;
                continue;
            }
            let theta = ((py - y) as f64).atan2((px - x) as f64) * 180.0 / PI;
            angles.push(theta);
        }

        angles.sort_by(|a, b| a.partial_cmp(b).unwrap());
        let n = angles.len();
        let mut extended = angles.clone();
        extended.extend(angles.iter().map(|&a| a + 360.0));

        let mut max = 0;
        let mut left = 0;

        for right in 0..extended.len() {
            while extended[right] - extended[left] > angle {
                left += 1;
            }
            max = max.max(right - left + 1);
        }

        (max as i32) + same
    }
}