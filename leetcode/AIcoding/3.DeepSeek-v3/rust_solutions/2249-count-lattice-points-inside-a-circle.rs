impl Solution {
    pub fn count_lattice_points(circles: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashSet;
        let mut points = HashSet::new();

        for circle in circles {
            let x = circle[0];
            let y = circle[1];
            let r = circle[2];

            for i in (x - r)..=(x + r) {
                for j in (y - r)..=(y + r) {
                    if (i - x).pow(2) + (j - y).pow(2) <= r * r {
                        points.insert((i, j));
                    }
                }
            }
        }

        points.len() as i32
    }
}