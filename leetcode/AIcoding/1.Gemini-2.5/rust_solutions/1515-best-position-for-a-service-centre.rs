impl Solution {
    fn calculate_distance_sum(x: f64, y: f64, points: &Vec<Vec<i32>>) -> f64 {
        let mut sum_dist = 0.0;
        for p in points {
            let px = p[0] as f64;
            let py = p[1] as f64;
            let dx = px - x;
            let dy = py - y;
            sum_dist += (dx * dx + dy * dy).sqrt();
        }
        sum_dist
    }

    pub fn get_min_dist_sum(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        if n == 0 {
            return 0.0;
        }

        let mut current_x = 0.0;
        let mut current_y = 0.0;
        for p in &points {
            current_x += p[0] as f64;
            current_y += p[1] as f64;
        }
        current_x /= n as f64;
        current_y /= n as f64;

        let mut step = 100.0; 
        let epsilon = 1e-7;

        let directions: [(f64, f64); 8] = [
            (-1.0, 0.0), (1.0, 0.0), (0.0, -1.0), (0.0, 1.0),
            (-1.0, -1.0), (-1.0, 1.0), (1.0, -1.0), (1.0, 1.0),
        ];

        while step > epsilon {
            let mut best_x = current_x;
            let mut best_y = current_y;
            let mut min_dist_sum = Self::calculate_distance_sum(current_x, current_y, &points);

            let mut improved_in_this_step = false;

            for &(dx, dy) in &directions {
                let nx = current_x + dx * step;
                let ny = current_y + dy * step;
                let new_dist_sum = Self::calculate_distance_sum(nx, ny, &points);

                if new_dist_sum < min_dist_sum {
                    min_dist_sum = new_dist_sum;
                    best_x = nx;
                    best_y = ny;
                    improved_in_this_step = true;
                }
            }

            if improved_in_this_step {
                current_x = best_x;
                current_y = best_y;
            } else {
                step /= 2.0; 
            }
        }

        Self::calculate_distance_sum(current_x, current_y, &points)
    }
}