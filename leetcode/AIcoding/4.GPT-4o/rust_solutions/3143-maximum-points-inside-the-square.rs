pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
    if points.is_empty() {
        return 0;
    }
    let mut max_count = 1;
    let n = points.len();

    for i in 0..n {
        for j in i + 1..n {
            let (x1, y1) = (points[i][0], points[i][1]);
            let (x2, y2) = (points[j][0], points[j][1]);
            let x_min = (x1.min(x2) - 1).max(-1);
            let x_max = (x1.max(x2) + 1).min(100);
            let y_min = (y1.min(y2) - 1).max(-1);
            let y_max = (y1.max(y2) + 1).min(100);

            let mut count = 0;
            for k in 0..n {
                let (x, y) = (points[k][0], points[k][1]);
                if x >= x_min && x <= x_max && y >= y_min && y <= y_max {
                    count += 1;
                }
            }
            max_count = max_count.max(count);
        }
    }
    max_count
}