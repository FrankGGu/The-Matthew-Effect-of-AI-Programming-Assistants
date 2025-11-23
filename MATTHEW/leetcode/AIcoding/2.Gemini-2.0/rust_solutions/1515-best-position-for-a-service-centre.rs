impl Solution {
    pub fn get_min_dist_sum(positions: Vec<Vec<i32>>) -> f64 {
        let n = positions.len();
        let mut x_sum = 0.0;
        let mut y_sum = 0.0;
        for pos in &positions {
            x_sum += pos[0] as f64;
            y_sum += pos[1] as f64;
        }
        let mut x = x_sum / n as f64;
        let mut y = y_sum / n as f64;

        let mut step = 100.0;
        while step > 1e-6 {
            let mut best_x = x;
            let mut best_y = y;
            let mut min_dist = Self::calculate_distance(&positions, x, y);

            for dx in [-1.0, 0.0, 1.0] {
                for dy in [-1.0, 0.0, 1.0] {
                    let new_x = x + dx * step;
                    let new_y = y + dy * step;
                    let dist = Self::calculate_distance(&positions, new_x, new_y);
                    if dist < min_dist {
                        min_dist = dist;
                        best_x = new_x;
                        best_y = new_y;
                    }
                }
            }

            x = best_x;
            y = best_y;
            step /= 2.0;
        }

        Self::calculate_distance(&positions, x, y)
    }

    fn calculate_distance(positions: &Vec<Vec<i32>>, x: f64, y: f64) -> f64 {
        let mut total_distance = 0.0;
        for pos in positions {
            let dx = x - pos[0] as f64;
            let dy = y - pos[1] as f64;
            total_distance += (dx * dx + dy * dy).sqrt();
        }
        total_distance
    }
}