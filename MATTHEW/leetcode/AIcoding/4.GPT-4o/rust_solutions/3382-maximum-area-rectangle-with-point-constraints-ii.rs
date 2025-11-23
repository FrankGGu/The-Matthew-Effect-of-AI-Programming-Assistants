use std::collections::HashSet;

pub fn max_area(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> i32 {
    let point_set: HashSet<(i32, i32)> = points.iter().map(|p| (p[0], p[1])).collect();
    let mut max_area = 0;

    for (x1, y1) in rectangles.iter().map(|r| (r[0], r[1])) {
        for (x2, y2) in rectangles.iter().map(|r| (r[2], r[3])) {
            if point_set.contains(&(x1, y1)) && point_set.contains(&(x1, y2)) && 
               point_set.contains(&(x2, y1)) && point_set.contains(&(x2, y2)) {
                let area = (x2 - x1).abs() * (y2 - y1).abs();
                max_area = max_area.max(area);
            }
        }
    }

    max_area
}