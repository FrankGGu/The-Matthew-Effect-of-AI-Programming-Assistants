use std::collections::HashMap;

impl Solution {
    pub fn car_pooling(trips: Vec<Vec<i32>>, capacity: i32) -> bool {
        let mut changes = HashMap::new();
        for trip in trips {
            let (num_passengers, start, end) = (trip[0], trip[1], trip[2]);
            *changes.entry(start).or_insert(0) += num_passengers;
            *changes.entry(end).or_insert(0) -= num_passengers;
        }

        let mut current_capacity = 0;
        let mut time_points: Vec<i32> = changes.keys().cloned().collect();
        time_points.sort();

        for point in time_points {
            current_capacity += changes[&point];
            if current_capacity > capacity {
                return false;
            }
        }
        true
    }
}