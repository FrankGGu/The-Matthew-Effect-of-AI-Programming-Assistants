use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_unique_subjects(teachers: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut teacher_subjects: HashMap<i32, HashSet<i32>> = HashMap::new();

        for entry in teachers {
            let teacher_id = entry[0];
            let subject_id = entry[1];

            teacher_subjects.entry(teacher_id)
                .or_insert_with(HashSet::new)
                .insert(subject_id);
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        for (teacher_id, subjects) in teacher_subjects {
            result.push(vec![teacher_id, subjects.len() as i32]);
        }

        result.sort_unstable_by_key(|v| v[0]);

        result
    }
}