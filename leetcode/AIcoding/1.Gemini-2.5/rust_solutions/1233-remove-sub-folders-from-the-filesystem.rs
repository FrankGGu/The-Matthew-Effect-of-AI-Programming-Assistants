impl Solution {
    pub fn remove_subfolders(mut folders: Vec<String>) -> Vec<String> {
        folders.sort_unstable();

        let mut result: Vec<String> = Vec::new();

        for folder in folders {
            if result.is_empty() {
                result.push(folder);
            } else {
                let last_added_folder = result.last().unwrap();

                let is_subfolder = folder.starts_with(last_added_folder)
                                   && folder.len() > last_added_folder.len()
                                   && folder.as_bytes()[last_added_folder.len()] == b'/';

                if !is_subfolder {
                    result.push(folder);
                }
            }
        }

        result
    }
}