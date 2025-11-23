impl Solution {
    pub fn best_coordinate(towers: Vec<Vec<i32>>, radius: i32) -> Vec<i32> {
        let mut max_quality = 0;
        let mut best_coordinate = vec![0, 0];

        let mut min_x = i32::MAX;
        let mut min_y = i32::MAX;
        let mut max_x = i32::MIN;
        let mut max_y = i32::MIN;

        for tower in &towers {
            min_x = min_x.min(tower[0]);
            min_y = min_y.min(tower[1]);
            max_x = max_x.max(tower[0]);
            max_y = max_y.max(tower[1]);
        }

        for x in min_x..=max_x {
            for y in min_y..=max_y {
                let mut quality = 0;
                for tower in &towers {
                    let distance = ((x - tower[0]).pow(2) + (y - tower[1]).pow(2)) as f64;
                    if distance <= (radius * radius) as f64 {
                        quality += (tower[2] as f64 / (1.0 + distance.sqrt())) as i32;
                    }
                }

                if quality > max_quality {
                    max_quality = quality;
                    best_coordinate = vec![x, y];
                }
            }
        }

        best_coordinate
    }
}