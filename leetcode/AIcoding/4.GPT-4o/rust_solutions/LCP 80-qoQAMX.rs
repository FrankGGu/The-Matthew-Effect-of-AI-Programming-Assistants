pub fn is_ancestor(ancestor: Vec<String>, target: Vec<String>) -> bool {
    let mut ancestor_set: std::collections::HashSet<&str> = ancestor.iter().map(|s| s.as_str()).collect();

    for t in target {
        if ancestor_set.contains(t.as_str()) {
            return true;
        }
    }

    false
}