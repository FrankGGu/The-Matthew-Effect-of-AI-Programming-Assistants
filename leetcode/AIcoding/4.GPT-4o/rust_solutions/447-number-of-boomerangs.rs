use std::collections::HashMap;

pub fn number_of_boomerangs(points: Vec<Vec<i32>>) -> i32 {
    let mut count = 0;
    for i in &points {
        let mut distance_map = HashMap::new();
        for j in &points {
            let dist = (i[0] - j[0]).pow(2) + (i[1] - j[1]).pow(2);
            *distance_map.entry(dist).or_insert(0) += 1;
        }
        for &v in distance_map.values() {
            count += v * (v - 1);
        }
    }
    count
}