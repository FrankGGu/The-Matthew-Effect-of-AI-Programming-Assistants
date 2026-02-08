use std::collections::HashMap;

pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
    let mut files_map: HashMap<String, Vec<String>> = HashMap::new();

    for path in paths {
        let parts: Vec<&str> = path.split(' ').collect();
        let directory = parts[0];

        for file in &parts[1..] {
            let split_index = file.find('(').unwrap();
            let filename = &file[..split_index];
            let content = &file[split_index + 1..file.len() - 1];
            let full_path = format!("{}/{}", directory, filename);
            files_map.entry(content.to_string()).or_default().push(full_path);
        }
    }

    files_map.values().filter(|v| v.len() > 1).cloned().collect()
}