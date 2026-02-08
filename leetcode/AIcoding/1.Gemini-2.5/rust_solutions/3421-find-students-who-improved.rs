impl Solution {
    pub fn find_students_who_improved(scores: Vec<Vec<i32>>) -> Vec<i32> {
        let mut improved_students = Vec::new();

        for student_record in scores {
            // Assuming each inner vector is [student_id, score_period_1, score_period_2]
            // and we need to find students where score_period_2 > score_period_1.
            if student_record.len() >= 3 && student_record[2] > student_record[1] {
                improved_students.push(student_record[0]);
            }
        }

        improved_students.sort();
        improved_students
    }
}