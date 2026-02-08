use std::collections::HashSet;

impl Solution {
    pub fn dest_city(paths: Vec<Vec<String>>) -> String {
        let mut source_cities: HashSet<&str> = HashSet::new();

        for path in &paths {
            source_cities.insert(&path[0]);
        }

        for path in &paths {
            let dest_city = &path[1];
            if !source_cities.contains(dest_city.as_str()) {
                return dest_city.clone();
            }
        }

        unreachable!()
    }
}