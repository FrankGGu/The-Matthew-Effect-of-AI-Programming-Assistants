impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn closest_dessert_cost(upper: i32, lower: i32, costs: Vec<i32>) -> Vec<i32> {
        let mut result = HashSet::new();
        for cost in costs {
            let mut temp = vec![cost];
            for i in 0..=10 {
                for j in 0..=10 {
                    let mut new_cost = cost;
                    for _ in 0..i {
                        new_cost += 5;
                    }
                    for _ in 0..j {
                        new_cost += 7;
                    }
                    if new_cost >= lower && new_cost <= upper {
                        result.insert(new_cost);
                    }
                }
            }
        }
        let mut result_vec: Vec<i32> = result.into_iter().collect();
        result_vec.sort();
        result_vec
    }
}
}