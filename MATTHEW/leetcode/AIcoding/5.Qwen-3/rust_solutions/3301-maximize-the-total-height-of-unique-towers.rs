impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_total_height(towers: Vec<Vec<i32>>) -> i32 {
        let mut height_map = HashMap::new();
        for tower in towers {
            let mut current_height = 0;
            for h in tower {
                current_height += h;
                *height_map.entry(h).or_insert(0) += 1;
            }
        }

        let mut heights: Vec<_> = height_map.into_iter().collect();
        heights.sort_by(|a, b| b.0.cmp(a.0));

        let mut total = 0;
        let mut count = 0;
        for (h, c) in heights {
            if count < 3 {
                total += h * c;
                count += 1;
            } else {
                break;
            }
        }

        total
    }
}
}