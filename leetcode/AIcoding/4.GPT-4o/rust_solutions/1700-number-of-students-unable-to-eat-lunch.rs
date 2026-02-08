pub fn count_students(students: Vec<i32>, sandwiches: Vec<i32>) -> i32 {
    let mut student_count = [0; 2];
    for &student in &students {
        student_count[student as usize] += 1;
    }

    for &sandwich in &sandwiches {
        if student_count[sandwich as usize] == 0 {
            return student_count[0] + student_count[1];
        }
        student_count[sandwich as usize] -= 1;
    }

    0
}