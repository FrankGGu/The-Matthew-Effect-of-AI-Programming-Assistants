use std::collections::HashMap;

impl Solution {
    pub fn kth_distinct(arr: Vec<String>, k: i32) -> String {
        let mut count_map = HashMap::new();
        for s in &arr {
            *count_map.entry(s).or_insert(0) += 1;
        }
        let mut k = k;
        for s in arr {
            if count_map[&s] == 1 {
                k -= 1;
                if k == 0 {
                    return s;
                }
            }
        }
        String::new()
    }
}