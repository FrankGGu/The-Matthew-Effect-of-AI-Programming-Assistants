use std::collections::HashSet;

impl Solution {
    pub fn remove_subfolders(folder: Vec<String>) -> Vec<String> {
        let mut folders = folder;
        folders.sort();
        let mut result = Vec::new();
        let mut seen = HashSet::new();

        for f in folders {
            let parts: Vec<&str> = f.split('/').collect();
            let mut is_subfolder = false;
            let mut path = String::new();

            for i in 1..parts.len() {
                path.push('/');
                path.push_str(parts[i]);
                if seen.contains(&path) {
                    is_subfolder = true;
                    break;
                }
            }

            if !is_subfolder {
                seen.insert(f.clone());
                result.push(f);
            }
        }

        result
    }
}