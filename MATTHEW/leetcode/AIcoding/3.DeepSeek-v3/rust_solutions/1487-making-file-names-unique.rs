use std::collections::HashMap;

impl Solution {
    pub fn get_folder_names(names: Vec<String>) -> Vec<String> {
        let mut name_map = HashMap::new();
        let mut result = Vec::new();

        for name in names {
            if !name_map.contains_key(&name) {
                name_map.insert(name.clone(), 1);
                result.push(name);
            } else {
                let mut k = *name_map.get(&name).unwrap();
                let mut new_name = format!("{}({})", name, k);
                while name_map.contains_key(&new_name) {
                    k += 1;
                    new_name = format!("{}({})", name, k);
                }
                name_map.insert(name.clone(), k + 1);
                name_map.insert(new_name.clone(), 1);
                result.push(new_name);
            }
        }

        result
    }
}