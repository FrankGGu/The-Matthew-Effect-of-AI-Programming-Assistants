use std::f64::consts::PI;

pub fn visible_points(points: Vec<Vec<i32>>, angle: i32, location: Vec<i32>) -> i32 {
    let mut angles = Vec::new();
    let location = (location[0] as f64, location[1] as f64);

    for point in points {
        let (x, y) = (point[0] as f64, point[1] as f64);
        if (x, y) == location {
            continue;
        }
        let angle = (y - location.1).atan2(x - location.0) * 180.0 / PI;
        angles.push(angle);
    }

    angles.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let n = angles.len();
    let angle = angle as f64;
    let mut angles = angles.clone();

    for i in 0..n {
        angles.push(angles[i] + 360.0);
    }

    let mut max_count = 0;
    let mut j = 0;

    for i in 0..n {
        while j < angles.len() && angles[j] <= angles[i] + angle as f64 {
            j += 1;
        }
        max_count = max_count.max(j - i);
    }

    max_count as i32 + points.iter().filter(|p| p[0] == location[0] && p[1] == location[1]).count() as i32
}