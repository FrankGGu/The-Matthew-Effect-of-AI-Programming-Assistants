use std::collections::HashSet;

pub fn find_students(improved: Vec<i32>, grades: Vec<i32>) -> Vec<i32> {
    let mut result = Vec::new();
    let improved_set: HashSet<i32> = improved.into_iter().collect();

    for (i, &grade) in grades.iter().enumerate() {
        if improved_set.contains(&(grade + 1)) {
            result.push(i as i32);
        }
    }

    result
}