impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Teacher {
    pub teacher_id: i32,
    pub subject: String,
}

pub fn count_unique_subjects(teachers: Vec<Teacher>) -> Vec<Vec<String>> {
    let mut map = HashMap::new();

    for teacher in teachers {
        let count = map.entry(teacher.teacher_id).or_insert(0);
        *count += 1;
    }

    let mut result = Vec::new();
    for (id, count) in map {
        result.push(vec![id.to_string(), count.to_string()]);
    }

    result.sort_by_key(|k| k[0].parse::<i32>().unwrap());
    result
}
}