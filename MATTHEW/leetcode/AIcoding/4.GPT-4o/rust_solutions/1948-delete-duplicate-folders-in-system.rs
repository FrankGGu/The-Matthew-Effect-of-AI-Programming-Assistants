use std::collections::HashMap;

pub fn delete_duplicate_folder(paths: Vec<String>) -> Vec<String> {
    let mut map: HashMap<String, Vec<String>> = HashMap::new();
    let mut result = Vec::new();

    for path in paths {
        let parts: Vec<&str> = path.split('/').collect();
        let mut current = String::new();

        for part in parts {
            current.push_str(part);
            current.push('/');
            map.entry(current.clone()).or_insert_with(Vec::new).push(part.to_string());
        }
    }

    let mut seen = HashMap::new();

    fn dfs(path: &str, map: &HashMap<String, Vec<String>>, seen: &mut HashMap<String, bool>) -> Option<String> {
        if seen.contains_key(path) {
            return None;
        }
        seen.insert(path.to_string(), true);

        let mut subfolders = map.get(path).unwrap_or(&Vec::new()).clone();
        subfolders.sort();

        let mut folder = String::new();
        for sub in subfolders {
            let sub_path = format!("{}/{}", path, sub);
            if let Some(f) = dfs(&sub_path, map, seen) {
                folder.push_str(&f);
                folder.push('/');
            }
        }

        if folder.is_empty() {
            None
        } else {
            Some(format!("{}/", path))
        }
    }

    dfs("", &map, &mut seen);

    for key in seen.keys() {
        if let Some(folder) = dfs(key, &map, &mut HashMap::new()) {
            result.push(folder);
        }
    }

    result.sort();
    result
}