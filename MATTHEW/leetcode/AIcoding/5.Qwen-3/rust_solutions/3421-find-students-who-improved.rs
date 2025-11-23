impl Solution {

use std::collections::HashSet;

#[derive(Debug, PartialEq, Eq)]
pub struct Student {
    pub id: i32,
    pub name: String,
    pub score: i32,
}

pub fn find_students(students: Vec<Student>) -> Vec<Student> {
    let mut student_scores = std::collections::HashMap::new();
    let mut result = Vec::new();

    for student in students {
        let scores = student_scores.entry(student.id).or_insert_with(HashSet::new);
        scores.insert(student.score);
    }

    for student in students {
        if let Some(scores) = student_scores.get(&student.id) {
            if scores.len() >= 2 && scores.iter().next() < scores.iter().next_back() {
                result.push(student);
            }
        }
    }

    result
}
}