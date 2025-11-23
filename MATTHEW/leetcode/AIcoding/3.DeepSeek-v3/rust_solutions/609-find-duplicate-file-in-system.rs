use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut content_map: HashMap<String, Vec<String>> = HashMap::new();

        for path in paths {
            let parts: Vec<&str> = path.split(' ').collect();
            let dir = parts[0];

            for file_info in &parts[1..] {
                let file_parts: Vec<&str> = file_info.split('(').collect();
                let file_name = file_parts[0];
                let content = file_parts[1].strip_suffix(')').unwrap();

                let full_path = format!("{}/{}", dir, file_name);
                content_map.entry(content.to_string()).or_default().push(full_path);
            }
        }

        content_map.into_values().filter(|v| v.len() > 1).collect()
    }
}