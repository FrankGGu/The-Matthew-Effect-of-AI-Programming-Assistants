use std::collections::HashMap;

impl Solution {
    pub fn get_folder_names(names: Vec<String>) -> Vec<String> {
        let mut seen: HashMap<String, i32> = HashMap::new();
        let mut result: Vec<String> = Vec::new();

        for name in names {
            if seen.contains_key(&name) {
                let mut k = *seen.get(&name).unwrap();
                let mut new_name = format!("{}({})", name, k);
                while seen.contains_key(&new_name) {
                    k += 1;
                    new_name = format!("{}({})", name, k);
                }
                seen.insert(name.clone(), k + 1);
                seen.insert(new_name.clone(), 1);
                result.push(new_name);
            } else {
                seen.insert(name.clone(), 1);
                result.push(name);
            }
        }

        result
    }
}