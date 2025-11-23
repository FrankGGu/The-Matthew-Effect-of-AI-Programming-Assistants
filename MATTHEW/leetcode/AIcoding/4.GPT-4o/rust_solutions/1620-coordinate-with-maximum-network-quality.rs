impl Solution {
    pub fn best_coordinate(towers: Vec<Vec<i32>>, radius: i32) -> Vec<i32> {
        let mut best_quality = 0;
        let mut best_coordinate = vec![0, 0];

        for x in 0..101 {
            for y in 0..101 {
                let mut quality = 0;

                for tower in &towers {
                    let (tx, ty, tq) = (tower[0], tower[1], tower[2]);
                    let distance = ((tx - x).pow(2) + (ty - y).pow(2)) as f64;

                    if distance <= (radius * radius) as f64 {
                        quality += (tq as f64 / (1.0 + distance.sqrt())) as i32;
                    }
                }

                if quality > best_quality || (quality == best_quality && (x > best_coordinate[0] || (x == best_coordinate[0] && y > best_coordinate[1]))) {
                    best_quality = quality;
                    best_coordinate = vec![x, y];
                }
            }
        }

        best_coordinate
    }
}