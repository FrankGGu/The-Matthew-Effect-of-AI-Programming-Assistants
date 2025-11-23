impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn closest_equal_queries(arr: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = arr.len();
        let mut pos_map = HashMap::new();

        for i in 0..n {
            pos_map.entry(arr[i]).or_insert(Vec::new()).push(i);
        }

        let mut result = Vec::new();

        for q in queries {
            let x = q[0];
            let idx = q[1] as usize;

            if let Some(positions) = pos_map.get(&x) {
                let mut left = 0;
                let mut right = positions.len() - 1;
                let mut closest = usize::MAX;

                while left <= right {
                    let mid = (left + right) / 2;
                    match positions[mid].cmp(&idx) {
                        Ordering::Less => left = mid + 1,
                        Ordering::Greater => right = mid - 1,
                        Ordering::Equal => {
                            closest = mid;
                            break;
                        }
                    }
                }

                if closest == usize::MAX {
                    if left < positions.len() {
                        closest = left;
                    }
                    if right >= 0 {
                        closest = right;
                    }
                }

                let closest_idx = positions[closest];
                let mut min_dist = i32::MAX;
                let mut res = -1;

                for &p in positions.iter() {
                    let dist = (p as i32 - idx as i32).abs();
                    if dist < min_dist {
                        min_dist = dist;
                        res = p as i32;
                    }
                }

                result.push(res);
            } else {
                result.push(-1);
            }
        }

        result
    }
}
}