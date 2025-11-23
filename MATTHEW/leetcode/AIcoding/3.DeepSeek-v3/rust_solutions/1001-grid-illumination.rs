use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn grid_illumination(n: i32, lamps: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut row_counts = HashMap::new();
        let mut col_counts = HashMap::new();
        let mut diag1_counts = HashMap::new();
        let mut diag2_counts = HashMap::new();
        let mut lamp_set = HashSet::new();

        for lamp in &lamps {
            let (x, y) = (lamp[0], lamp[1]);
            if lamp_set.insert((x, y)) {
                *row_counts.entry(x).or_insert(0) += 1;
                *col_counts.entry(y).or_insert(0) += 1;
                *diag1_counts.entry(x + y).or_insert(0) += 1;
                *diag2_counts.entry(x - y).or_insert(0) += 1;
            }
        }

        let mut result = Vec::new();
        for query in &queries {
            let (x, y) = (query[0], query[1]);
            let illuminated = row_counts.get(&x).map_or(0, |&v| v) > 0
                || col_counts.get(&y).map_or(0, |&v| v) > 0
                || diag1_counts.get(&(x + y)).map_or(0, |&v| v) > 0
                || diag2_counts.get(&(x - y)).map_or(0, |&v| v) > 0;
            result.push(if illuminated { 1 } else { 0 });

            for dx in -1..=1 {
                for dy in -1..=1 {
                    let nx = x + dx;
                    let ny = y + dy;
                    if nx >= 0 && nx < n && ny >= 0 && ny < n && lamp_set.remove(&(nx, ny)) {
                        *row_counts.get_mut(&nx).unwrap() -= 1;
                        *col_counts.get_mut(&ny).unwrap() -= 1;
                        *diag1_counts.get_mut(&(nx + ny)).unwrap() -= 1;
                        *diag2_counts.get_mut(&(nx - ny)).unwrap() -= 1;
                    }
                }
            }
        }

        result
    }
}