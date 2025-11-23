impl Solution {
    pub fn best_coordinate(towers: Vec<Vec<i32>>, radius: i32) -> Vec<i32> {
        let mut max_quality = 0;
        let mut result = vec![0, 0];
        let radius_sq = radius * radius;

        for x in 0..=50 {
            for y in 0..=50 {
                let mut quality = 0;
                for tower in &towers {
                    let dx = x - tower[0];
                    let dy = y - tower[1];
                    let distance_sq = dx * dx + dy * dy;
                    if distance_sq <= radius_sq {
                        let distance = (distance_sq as f64).sqrt();
                        quality += (tower[2] as f64 / (1.0 + distance)).floor() as i32;
                    }
                }
                if quality > max_quality || (quality == max_quality && (x < result[0] || (x == result[0] && y < result[1]))) {
                    max_quality = quality;
                    result = vec![x, y];
                }
            }
        }

        result
    }
}