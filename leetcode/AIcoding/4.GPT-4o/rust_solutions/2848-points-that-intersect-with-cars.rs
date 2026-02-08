use std::collections::HashMap;

pub fn count_intersections(cars: Vec<Vec<i32>>) -> Vec<i32> {
    let mut points = HashMap::new();

    for car in cars {
        let (start, end) = (car[0], car[1]);
        for point in start..=end {
            *points.entry(point).or_insert(0) += 1;
        }
    }

    let mut result = vec![0; cars.len()];

    for (i, car) in cars.iter().enumerate() {
        let (start, end) = (car[0], car[1]);
        for point in start..=end {
            if let Some(&count) = points.get(&point) {
                result[i] += count;
            }
        }
    }

    result
}