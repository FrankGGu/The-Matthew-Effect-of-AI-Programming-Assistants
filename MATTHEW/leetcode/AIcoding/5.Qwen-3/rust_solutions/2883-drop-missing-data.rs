impl Solution {

use std::collections::HashMap;

fn drop_missing_data(students: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut result = Vec::new();
    for student in students {
        if student.len() == 3 && !student[0].is_empty() && !student[1].is_empty() && !student[2].is_empty() {
            result.push(student);
        }
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_drop_missing_data() {
        assert_eq!(
            drop_missing_data(vec![
                vec!["Alice".to_string(), "M".to_string(), "15".to_string()],
                vec!["Bob".to_string(), "".to_string(), "12".to_string()],
                vec!["Eve".to_string(), "F".to_string(), "".to_string()]
            ]),
            vec![
                vec!["Alice".to_string(), "M".to_string(), "15".to_string()]
            ]
        );
    }
}
}