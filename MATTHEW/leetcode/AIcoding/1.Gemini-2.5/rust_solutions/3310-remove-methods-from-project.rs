use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn remove_methods_from_project(project_code: Vec<String>, methods_to_remove: Vec<String>) -> Vec<String> {
        let methods_set: HashSet<String> = methods_to_remove.into_iter().collect();
        project_code.into_iter().filter(|line| !methods_set.contains(line)).collect()
    }
}