use std::collections::HashSet;

impl Solution {
    pub fn dest_city(paths: Vec<Vec<String>>) -> String {
        let mut starts = HashSet::new();
        let mut ends = HashSet::new();

        for path in &paths {
            starts.insert(path[0].clone());
            ends.insert(path[1].clone());
        }

        for end in &ends {
            if !starts.contains(end) {
                return end.clone();
            }
        }

        "".to_string()
    }
}