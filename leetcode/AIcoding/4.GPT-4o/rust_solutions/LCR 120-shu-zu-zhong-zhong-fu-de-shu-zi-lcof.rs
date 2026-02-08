use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut map: HashMap<String, Vec<String>> = HashMap::new();

        for path in paths {
            let parts: Vec<&str> = path.split(' ').collect();
            let dir = parts[0];

            for file in &parts[1..] {
                let idx = file.find('(').unwrap();
                let content = &file[idx..];
                let filename = &file[..idx];

                map.entry(content.to_string()).or_insert_with(Vec::new).push(format!("{}/{}", dir, filename));
            }
        }

        map.values().filter(|v| v.len() > 1).cloned().collect()
    }
}