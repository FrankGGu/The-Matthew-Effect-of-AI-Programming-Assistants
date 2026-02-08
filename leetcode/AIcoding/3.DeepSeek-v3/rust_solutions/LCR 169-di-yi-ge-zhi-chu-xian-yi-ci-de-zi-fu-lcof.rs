use std::collections::HashMap;

impl Solution {
    pub fn dismantling_action(arr: String) -> i32 {
        let mut map = HashMap::new();
        let bytes = arr.as_bytes();
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..bytes.len() {
            let c = bytes[right];
            if let Some(&pos) = map.get(&c) {
                left = left.max(pos + 1);
            }
            map.insert(c, right as i32);
            max_len = max_len.max((right as i32 - left + 1));
        }

        max_len
    }
}