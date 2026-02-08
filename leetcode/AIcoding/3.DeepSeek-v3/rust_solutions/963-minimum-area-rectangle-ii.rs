use std::collections::HashMap;

impl Solution {
    pub fn min_area_free_rect(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        let mut map: HashMap<(i32, i32, i32), Vec<(usize, usize)>> = HashMap::new();

        for i in 0..n {
            for j in i + 1..n {
                let x1 = points[i][0];
                let y1 = points[i][1];
                let x2 = points[j][0];
                let y2 = points[j][1];

                let dx = x1 + x2;
                let dy = y1 + y2;
                let len = (x1 - x2).pow(2) + (y1 - y2).pow(2);

                map.entry((dx, dy, len)).or_default().push((i, j));
            }
        }

        let mut min_area = std::f64::MAX;

        for (_, pairs) in map {
            let m = pairs.len();
            for i in 0..m {
                for j in i + 1..m {
                    let (a, b) = pairs[i];
                    let (c, d) = pairs[j];

                    let x1 = points[a][0] as f64;
                    let y1 = points[a][1] as f64;
                    let x2 = points[b][0] as f64;
                    let y2 = points[b][1] as f64;
                    let x3 = points[c][0] as f64;
                    let y3 = points[c][1] as f64;

                    let area = ((x1 - x3).powi(2) + (y1 - y3).powi(2)).sqrt() * 
                                ((x2 - x3).powi(2) + (y2 - y3).powi(2)).sqrt();

                    if area < min_area {
                        min_area = area;
                    }
                }
            }
        }

        if min_area == std::f64::MAX {
            0.0
        } else {
            min_area
        }
    }
}