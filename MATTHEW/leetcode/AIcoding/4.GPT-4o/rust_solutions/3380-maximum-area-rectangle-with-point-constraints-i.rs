use std::collections::HashSet;

pub fn max_area_rect(points: Vec<Vec<i32>>) -> i32 {
    let mut point_set = HashSet::new();
    for point in &points {
        point_set.insert((point[0], point[1]));
    }

    let mut max_area = 0;
    let n = points.len();

    for i in 0..n {
        for j in i + 1..n {
            let (x1, y1) = (points[i][0], points[i][1]);
            let (x2, y2) = (points[j][0], points[j][1]);
            if x1 != x2 && y1 != y2 {
                if point_set.contains(&(x1, y2)) && point_set.contains(&(x2, y1)) {
                    let area = (x2 - x1).abs() * (y2 - y1).abs();
                    max_area = max_area.max(area);
                }
            }
        }
    }

    max_area
}