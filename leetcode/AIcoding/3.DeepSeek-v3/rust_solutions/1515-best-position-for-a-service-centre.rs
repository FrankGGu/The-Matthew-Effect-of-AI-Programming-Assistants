use std::f64;

impl Solution {
    pub fn get_min_dist_sum(positions: Vec<Vec<i32>>) -> f64 {
        let n = positions.len();
        let mut x = 0.0;
        let mut y = 0.0;
        for pos in &positions {
            x += pos[0] as f64;
            y += pos[1] as f64;
        }
        x /= n as f64;
        y /= n as f64;

        let mut step = 50.0;
        let mut min_dist = f64::MAX;

        while step > 1e-5 {
            let mut found = false;
            for &(dx, dy) in &[(0.0, step), (0.0, -step), (step, 0.0), (-step, 0.0)] {
                let nx = x + dx;
                let ny = y + dy;
                let dist = Self::calculate_distance(&positions, nx, ny);
                if dist < min_dist {
                    min_dist = dist;
                    x = nx;
                    y = ny;
                    found = true;
                    break;
                }
            }
            if !found {
                step /= 2.0;
            }
        }

        min_dist
    }

    fn calculate_distance(positions: &Vec<Vec<i32>>, x: f64, y: f64) -> f64 {
        let mut sum = 0.0;
        for pos in positions {
            let dx = pos[0] as f64 - x;
            let dy = pos[1] as f64 - y;
            sum += (dx * dx + dy * dy).sqrt();
        }
        sum
    }
}