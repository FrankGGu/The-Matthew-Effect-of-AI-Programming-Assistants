use std::collections::HashSet;

pub fn remove_subfolders(folder: Vec<String>) -> Vec<String> {
    let mut set: HashSet<String> = HashSet::new();
    let mut result: Vec<String> = Vec::new();

    for path in folder {
        let mut current = String::new();
        for part in path.split('/') {
            if !current.is_empty() {
                current.push('/');
            }
            current.push_str(part);
            if set.contains(&current) {
                break;
            }
        }
        if current == path {
            result.push(path);
        }
        set.insert(path);
    }

    result
}