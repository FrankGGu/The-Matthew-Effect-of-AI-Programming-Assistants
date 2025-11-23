impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn remove_methods_from_project(project: Vec<String>, methods_to_remove: Vec<String>) -> Vec<String> {
        let methods_set: HashSet<String> = methods_to_remove.into_iter().collect();
        project.into_iter().filter(|method| !methods_set.contains(method)).collect()
    }
}
}