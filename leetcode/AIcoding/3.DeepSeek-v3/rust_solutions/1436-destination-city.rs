use std::collections::HashSet;

impl Solution {
    pub fn dest_city(paths: Vec<Vec<String>>) -> String {
        let mut sources = HashSet::new();
        let mut destinations = HashSet::new();

        for path in paths {
            sources.insert(path[0].clone());
            destinations.insert(path[1].clone());
        }

        for dest in destinations {
            if !sources.contains(&dest) {
                return dest;
            }
        }

        String::new()
    }
}