use std::collections::HashMap;

impl Solution {
    pub fn closest_equal_elements(arr: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        let mut pos_map: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            pos_map.entry(num).or_default().push(i);
        }

        let mut res = Vec::with_capacity(queries.len());
        for &query in queries.iter() {
            if let Some(positions) = pos_map.get(&query) {
                let idx = positions.binary_search(&(query as usize)).unwrap_or_else(|x| x);
                let mut min_dist = i32::MAX;
                let mut closest = -1;

                if idx > 0 {
                    let left_pos = positions[idx - 1] as i32;
                    let dist = (query - left_pos).abs();
                    if dist < min_dist {
                        min_dist = dist;
                        closest = left_pos;
                    }
                }
                if idx < positions.len() {
                    let right_pos = positions[idx] as i32;
                    let dist = (query - right_pos).abs();
                    if dist < min_dist {
                        min_dist = dist;
                        closest = right_pos;
                    }
                }
                res.push(closest);
            } else {
                res.push(-1);
            }
        }
        res
    }
}