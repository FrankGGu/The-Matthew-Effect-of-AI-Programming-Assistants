use std::collections::HashSet;

impl Solution {
    pub fn unique_subjects(subjects: Vec<Vec<String>>) -> Vec<i32> {
        let mut result = Vec::new();
        for teacher_subjects in subjects {
            let unique_subjects: HashSet<_> = teacher_subjects.into_iter().collect();
            result.push(unique_subjects.len() as i32);
        }
        result
    }
}