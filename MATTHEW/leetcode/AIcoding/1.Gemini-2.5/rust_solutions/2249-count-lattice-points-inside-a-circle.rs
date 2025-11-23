use std::collections::HashSet;

impl Solution {
    pub fn count_lattice_points(circles: Vec<Vec<i32>>) -> i32 {
        let mut points_found: HashSet<(i32, i32)> = HashSet::new();

        for circle in circles {
            let cx = circle[0];
            let cy = circle[1];
            let r = circle[2];

            for x in (cx - r)..=(cx + r) {
                for y in (cy - r)..=(cy + r) {
                    let dx = x - cx;
                    let dy = y - cy;
                    if dx * dx + dy * dy <= r * r {
                        points_found.insert((x, y));
                    }
                }
            }
        }

        points_found.len() as i32
    }
}