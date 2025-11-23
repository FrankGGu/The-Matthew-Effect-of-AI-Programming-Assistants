pub fn max_happy_students(students: Vec<i32>, sandwiches: Vec<i32>) -> i32 {
    let mut count = [0; 2];
    for &student in &students {
        count[student as usize] += 1;
    }
    let mut i = 0;
    while i < sandwiches.len() && count[sandwiches[i] as usize] > 0 {
        count[sandwiches[i] as usize] -= 1;
        i += 1;
    }
    count[0] + count[1]
}