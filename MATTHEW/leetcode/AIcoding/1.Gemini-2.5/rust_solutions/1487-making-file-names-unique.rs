use std::collections::HashMap;

impl Solution {
    pub fn get_folder_names(names: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::with_capacity(names.len());
        let mut map: HashMap<String, i32> = HashMap::new();

        for name in names {
            if let Some(&k) = map.get(&name) {
                let mut current_k = k;
                let mut new_name: String;
                loop {
                    new_name = format!("{}({})", name, current_k);
                    if !map.contains_key(&new_name) {
                        result.push(new_name.clone());
                        map.insert(new_name, 1);
                        map.insert(name, current_k + 1);
                        break;
                    }
                    current_k += 1;
                }
            } else {
                result.push(name.clone());
                map.insert(name, 1);
            }
        }

        result
    }
}