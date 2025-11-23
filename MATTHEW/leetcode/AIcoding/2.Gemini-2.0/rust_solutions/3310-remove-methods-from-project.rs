use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn remove_methods(project: Vec<String>, methods: Vec<String>) -> Vec<String> {
        let methods_set: HashSet<String> = methods.into_iter().collect();
        project.into_iter().filter(|line| !methods_set.contains(line)).collect()
    }
}