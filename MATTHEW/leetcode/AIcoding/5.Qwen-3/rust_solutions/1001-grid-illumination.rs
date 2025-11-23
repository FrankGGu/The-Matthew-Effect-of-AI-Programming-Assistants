impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution {}

impl Solution {
    pub fn grid_illumination(
        n: i32,
        queries: Vec<Vec<i32>>,
        lamps: Vec<Vec<i32>>,
    ) -> Vec<bool> {
        let mut lamp_set = HashSet::new();
        let mut row_count = HashMap::new();
        let mut col_count = HashMap::new();
        let mut diag1_count = HashMap::new();
        let mut diag2_count = HashMap::new();

        for lamp in lamps {
            let (x, y) = (lamp[0], lamp[1]);
            if !lamp_set.contains(&(x, y)) {
                lamp_set.insert((x, y));
                *row_count.entry(x).or_insert(0) += 1;
                *col_count.entry(y).or_insert(0) += 1;
                *diag1_count.entry(x - y).or_insert(0) += 1;
                *diag2_count.entry(x + y).or_insert(0) += 1;
            }
        }

        let mut result = Vec::new();
        for query in queries {
            let (x, y) = (query[0], query[1]);
            let is_illuminated = *row_count.get(&x).unwrap_or(&0) > 0
                || *col_count.get(&y).unwrap_or(&0) > 0
                || *diag1_count.get(&(x - y)).unwrap_or(&0) > 0
                || *diag2_count.get(&(x + y)).unwrap_or(&0) > 0;
            result.push(is_illuminated);

            if lamp_set.contains(&(x, y)) {
                lamp_set.remove(&(x, y));
                *row_count.entry(x).or_insert(0) -= 1;
                *col_count.entry(y).or_insert(0) -= 1;
                *diag1_count.entry(x - y).or_insert(0) -= 1;
                *diag2_count.entry(x + y).or_insert(0) -= 1;

                for dx in [-1, 0, 1] {
                    for dy in [-1, 0, 1] {
                        let nx = x + dx;
                        let ny = y + dy;
                        if nx >= 0 && ny >= 0 && nx < n && ny < n {
                            if lamp_set.contains(&(nx, ny)) {
                                lamp_set.remove(&(nx, ny));
                                *row_count.entry(nx).or_insert(0) -= 1;
                                *col_count.entry(ny).or_insert(0) -= 1;
                                *diag1_count.entry(nx - ny).or_insert(0) -= 1;
                                *diag2_count.entry(nx + ny).or_insert(0) -= 1;
                            }
                        }
                    }
                }
            }
        }

        result
    }
}
}