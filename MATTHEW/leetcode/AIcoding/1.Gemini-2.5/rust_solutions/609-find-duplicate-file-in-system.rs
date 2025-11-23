use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut content_map: HashMap<String, Vec<String>> = HashMap::new();

        for path_str in paths {
            let parts: Vec<&str> = path_str.split_whitespace().collect();
            if parts.is_empty() {
                continue;
            }

            let dir_path = parts[0];

            for &file_entry in parts.iter().skip(1) {
                if let Some(open_paren_idx) = file_entry.find('(') {
                    let filename = &file_entry[..open_paren_idx];
                    let content_start = open_paren_idx + 1;
                    if let Some(close_paren_idx) = file_entry.find(')') {
                        if close_paren_idx > content_start {
                            let content = &file_entry[content_start..close_paren_idx];
                            let full_path = format!("{}/{}", dir_path, filename);
                            content_map.entry(content.to_string()).or_insert_with(Vec::new).push(full_path);
                        }
                    }
                }
            }
        }

        content_map.into_iter()
            .filter_map(|(_, files)| {
                if files.len() > 1 {
                    Some(files)
                } else {
                    None
                }
            })
            .collect()
    }
}