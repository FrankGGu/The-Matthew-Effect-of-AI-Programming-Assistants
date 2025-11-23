impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn check_distances(s: String, distance: Vec<i32>) -> bool {
        let mut map = HashMap::new();

        for (i, c) in s.chars().enumerate() {
            if let Some(&prev) = map.get(&c) {
                let idx = (c as u8 - b'a') as usize;
                if (i - prev - 1) as i32 != distance[idx] {
                    return false;
                }
            } else {
                map.insert(c, i);
            }
        }

        true
    }
}
}