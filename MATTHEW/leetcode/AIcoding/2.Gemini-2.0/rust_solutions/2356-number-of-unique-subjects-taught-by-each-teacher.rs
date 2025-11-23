use std::collections::HashSet;

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq, Hash)]
struct TeacherSubject {
    teacher_id: i32,
    subject_name: String,
}

impl Solution {
    pub fn count_unique_subjects(teacher: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut subject_counts: HashMap<i32, HashSet<String>> = HashMap::new();

        for record in teacher {
            let teacher_id = record[0].parse::<i32>().unwrap();
            let subject_name = record[1].clone();

            subject_counts.entry(teacher_id).or_insert(HashSet::new()).insert(subject_name);
        }

        let mut result: Vec<Vec<String>> = Vec::new();

        for (teacher_id, subjects) in subject_counts {
            result.push(vec![teacher_id.to_string(), subjects.len().to_string()]);
        }

        result
    }
}

struct Solution;