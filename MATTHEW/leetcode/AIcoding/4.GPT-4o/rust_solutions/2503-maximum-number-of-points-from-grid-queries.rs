use std::collections::HashMap;

pub fn max_points(queries: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> Vec<i32> {
    let mut results = Vec::new();
    let mut point_map: HashMap<(i32, i32), i32> = HashMap::new();

    for point in points {
        let x = point[0];
        let y = point[1];
        *point_map.entry((x, y)).or_insert(0) += 1;
    }

    for query in queries {
        let (x1, y1, x2, y2) = (query[0], query[1], query[2], query[3]);
        let mut count = 0;

        for (&(x, y), &c) in &point_map {
            if x1 <= x && x <= x2 && y1 <= y && y <= y2 {
                count += c;
            }
        }
        results.push(count);
    }

    results
}