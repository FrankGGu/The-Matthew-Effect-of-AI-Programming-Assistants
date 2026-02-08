use std::collections::HashSet;

pub fn min_rectangles(points: Vec<Vec<i32>>) -> i32 {
    let mut set = HashSet::new();
    for point in points.iter() {
        set.insert((point[0], point[1]));
    }

    let mut count = 0;

    for &(x, y) in set.iter() {
        if set.remove(&(x, y)) {
            count += 1;
            let mut max_x = x;
            let mut max_y = y;

            for &(nx, ny) in set.iter() {
                if nx >= x && ny >= y {
                    max_x = max_x.max(nx);
                    max_y = max_y.max(ny);
                }
            }

            for nx in x..=max_x {
                for ny in y..=max_y {
                    set.remove(&(nx, ny));
                }
            }
        }
    }

    count
}