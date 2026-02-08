impl Solution {
    pub fn largest_triangle_area(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        let mut max_area = 0.0;

        for i in 0..n {
            for j in (i + 1)..n {
                for k in (j + 1)..n {
                    let p1 = &points[i];
                    let p2 = &points[j];
                    let p3 = &points[k];

                    let x1 = p1[0] as f64;
                    let y1 = p1[1] as f64;
                    let x2 = p2[0] as f64;
                    let y2 = p2[1] as f64;
                    let x3 = p3[0] as f64;
                    let y3 = p3[1] as f64;

                    // Shoelace formula: 0.5 * |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)|
                    let area = 0.5 * (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)).abs();
                    max_area = max_area.max(area);
                }
            }
        }

        max_area
    }
}