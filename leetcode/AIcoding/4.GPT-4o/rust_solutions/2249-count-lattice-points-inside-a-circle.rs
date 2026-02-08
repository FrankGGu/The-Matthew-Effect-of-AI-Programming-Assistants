impl Solution {
    pub fn count_lattice_points(circles: Vec<Vec<i32>>) -> i32 {
        let mut points = std::collections::HashSet::new();
        for circle in circles {
            let (x, y, r) = (circle[0], circle[1], circle[2]);
            for dx in -r..=r {
                let dy_max = (r * r - dx * dx).sqrt() as i32;
                for dy in -dy_max..=dy_max {
                    points.insert((x + dx, y + dy));
                }
            }
        }
        points.len() as i32
    }
}