impl Solution {
    pub fn remove_subfolders(folder: Vec<String>) -> Vec<String> {
        let mut folder_sorted = folder;
        folder_sorted.sort();
        let mut result = Vec::new();
        let mut current_prefix = String::new();
        for path in folder_sorted {
            if !current_prefix.is_empty() && path.starts_with(&current_prefix) && path.as_bytes()[current_prefix.len()] == b'/' {
                continue;
            }
            result.push(path.clone());
            current_prefix = path;
        }
        result
    }
}