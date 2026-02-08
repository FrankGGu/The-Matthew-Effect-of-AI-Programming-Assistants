impl Solution {
    pub fn count_lattice_points(circles: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashSet;
        let mut set: HashSet<(i32, i32)> = HashSet::new();
        for circle in circles {
            let x = circle[0];
            let y = circle[1];
            let r = circle[2];
            for i in (x - r)..(x + r + 1) {
                for j in (y - r)..(y + r + 1) {
                    if (i - x) * (i - x) + (j - y) * (j - y) <= r * r {
                        set.insert((i, j));
                    }
                }
            }
        }
        set.len() as i32
    }
}