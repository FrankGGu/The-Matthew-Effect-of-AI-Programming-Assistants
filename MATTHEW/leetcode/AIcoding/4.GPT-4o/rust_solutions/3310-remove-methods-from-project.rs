impl Solution {
    pub fn remove_methods(project: Vec<String>, methods: Vec<String>) -> Vec<String> {
        let methods_set: std::collections::HashSet<_> = methods.into_iter().collect();
        project.into_iter().filter(|s| !methods_set.contains(s)).collect()
    }
}