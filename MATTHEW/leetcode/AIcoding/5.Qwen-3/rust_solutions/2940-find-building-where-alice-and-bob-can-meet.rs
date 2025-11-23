impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_meet(buildings: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for b in &buildings {
            let start = b[0];
            let end = b[1];
            *map.entry(start).or_insert(0) += 1;
            *map.entry(end + 1).or_insert(0) -= 1;
        }

        let mut events: Vec<_> = map.into_iter().collect();
        events.sort_by_key(|&(k, _)| k);

        let mut count = 0;
        let mut prev = 0;
        for (i, &(k, v)) in events.iter().enumerate() {
            if i > 0 {
                if count > 0 {
                    return prev;
                }
            }
            count += v;
            prev = k;
        }

        -1
    }
}
}