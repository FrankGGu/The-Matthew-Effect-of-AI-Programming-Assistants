impl Solution {
    pub fn dest_city(paths: Vec<Vec<String>>) -> String {
        let mut from_set = std::collections::HashSet::new();
        let mut to_set = std::collections::HashSet::new();

        for path in paths {
            from_set.insert(&path[0]);
            to_set.insert(&path[1]);
        }

        for city in to_set {
            if !from_set.contains(city) {
                return city.clone();
            }
        }

        String::new()
    }
}