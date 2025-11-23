use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut content_to_files: HashMap<String, Vec<String>> = HashMap::new();

        for path_str in paths {
            let parts: Vec<&str> = path_str.split_whitespace().collect();
            let directory = parts[0];

            for i in 1..parts.len() {
                let file_info = parts[i];
                let open_paren_index = file_info.find('(').unwrap();
                let close_paren_index = file_info.find(')').unwrap();

                let file_name = &file_info[..open_paren_index];
                let content = &file_info[open_paren_index + 1..close_paren_index];

                let full_path = format!("{}/{}", directory, file_name);

                content_to_files.entry(content.to_string()).or_insert(Vec::new()).push(full_path);
            }
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (_, files) in content_to_files {
            if files.len() > 1 {
                result.push(files);
            }
        }

        result
    }
}