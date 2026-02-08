use std::collections::HashSet;

impl Solution {
    pub fn number_of_points(cars: Vec<Vec<i32>>) -> i32 {
        let mut covered_points = [false; 101];
        let mut count = 0;

        for car in cars {
            let start = car[0] as usize;
            let end = car[1] as usize;
            for point in start..=end {
                if !covered_points[point] {
                    covered_points[point] = true;
                    count += 1;
                }
            }
        }
        count
    }
}