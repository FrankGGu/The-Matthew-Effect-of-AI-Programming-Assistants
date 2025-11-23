impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn min_swaps_couples(mut row: Vec<i32>) -> i32 {
        let mut pos = HashMap::new();
        for (i, &val) in row.iter().enumerate() {
            pos.insert(val, i);
        }

        let mut swaps = 0;
        for i in (0..row.len()).step_by(2) {
            let partner = row[i] ^ 1;
            if row[i + 1] != partner {
                let j = *pos.get(&partner).unwrap();
                row.swap(i + 1, j);
                *pos.get_mut(&row[j]).unwrap() = j;
                *pos.get_mut(&row[i + 1]).unwrap() = i + 1;
                swaps += 1;
            }
        }

        swaps
    }
}
}