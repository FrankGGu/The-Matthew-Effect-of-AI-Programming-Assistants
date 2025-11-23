pub fn min_area_rect(points: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut point_set: HashSet<(i32, i32)> = points.iter().map(|p| (p[0], p[1])).collect();
    let mut min_area = i32::MAX;

    for i in 0..points.len() {
        for j in (i + 1)..points.len() {
            if points[i][0] != points[j][0] && points[i][1] != points[j][1] {
                if point_set.contains(&(points[i][0], points[j][1])) && point_set.contains(&(points[j][0], points[i][1])) {
                    let area = (points[j][0] - points[i][0]).abs() * (points[j][1] - points[i][1]).abs();
                    min_area = min_area.min(area);
                }
            }
        }
    }

    if min_area == i32::MAX { 0 } else { min_area }
}