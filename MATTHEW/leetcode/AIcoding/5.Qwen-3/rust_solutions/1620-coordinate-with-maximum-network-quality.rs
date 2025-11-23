impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn best_coordinate(robots: Vec<Vec<i32>>, workers: Vec<Vec<i32>>) -> Vec<i32> {
        let mut quality_map = HashMap::new();
        for robot in &robots {
            let x = robot[0];
            let y = robot[1];
            let q = robot[2];
            *quality_map.entry((x, y)).or_insert(0) += q;
        }

        let mut max_quality = 0;
        let mut best_coord = vec![0, 0];

        for worker in &workers {
            let wx = worker[0];
            let wy = worker[1];
            let r = worker[2];

            for (x, y) in quality_map.keys() {
                let dx = (wx - x).abs();
                let dy = (wy - y).abs();
                if dx <= r && dy <= r {
                    let q = *quality_map.get(&(x, y)).unwrap();
                    if q > max_quality {
                        max_quality = q;
                        best_coord = vec![*x, *y];
                    } else if q == max_quality {
                        if *x < best_coord[0] || (*x == best_coord[0] && *y < best_coord[1]) {
                            best_coord = vec![*x, *y];
                        }
                    }
                }
            }
        }

        best_coord
    }
}
}