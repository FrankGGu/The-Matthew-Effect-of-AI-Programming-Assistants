pub fn count_right_triangles(points: Vec<Vec<i32>>) -> i32 {
    let mut count = 0;
    let n = points.len();
    let mut map = std::collections::HashMap::new();

    for i in 0..n {
        for j in (i + 1)..n {
            let dx = points[j][0] - points[i][0];
            let dy = points[j][1] - points[i][1];
            let slope = (dy, dx);
            *map.entry(slope).or_insert(0) += 1;
        }
    }

    for &(_, &v) in map.iter() {
        count += v * (v - 1) / 2;
    }

    count
}