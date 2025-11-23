use std::collections::HashMap;

impl Solution {
    pub fn kth_distinct(arr: Vec<String>, k: i32) -> String {
        let mut counts: HashMap<&str, i32> = HashMap::new();

        for s in arr.iter() {
            *counts.entry(s).or_insert(0) += 1;
        }

        let mut distinct_count = 0;
        for s in arr.iter() {
            if *counts.get(s.as_str()).unwrap_or(&0) == 1 {
                distinct_count += 1;
                if distinct_count == k {
                    return s.clone();
                }
            }
        }

        String::new()
    }
}