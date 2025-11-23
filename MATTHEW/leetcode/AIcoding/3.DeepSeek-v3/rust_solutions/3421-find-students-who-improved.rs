use std::collections::HashMap;

impl Solution {
    pub fn find_students(score_card: Vec<Vec<i32>>) -> Vec<i32> {
        let mut student_scores: HashMap<i32, Vec<i32>> = HashMap::new();

        for entry in score_card {
            let student_id = entry[0];
            let score = entry[1];
            student_scores.entry(student_id).or_insert(Vec::new()).push(score);
        }

        let mut improved_students = Vec::new();

        for (student_id, scores) in student_scores {
            if scores.len() >= 2 {
                let mut improved = true;
                for i in 1..scores.len() {
                    if scores[i] <= scores[i - 1] {
                        improved = false;
                        break;
                    }
                }
                if improved {
                    improved_students.push(student_id);
                }
            }
        }

        improved_students.sort();
        improved_students
    }
}