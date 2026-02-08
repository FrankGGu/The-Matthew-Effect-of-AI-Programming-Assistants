use std::collections::HashSet;

impl Solution {
    pub fn get_folder_names(names: Vec<String>) -> Vec<String> {
        let mut seen = HashSet::new();
        let mut result = Vec::new();

        for name in names {
            let mut new_name = name.clone();
            let mut count = 1;
            while seen.contains(&new_name) {
                new_name = format!("{}({})", name, count);
                count += 1;
            }
            seen.insert(new_name.clone());
            result.push(new_name);
        }

        result
    }
}