impl Solution {
    pub fn count_students(students: Vec<i32>, sandwiches: Vec<i32>) -> i32 {
        let mut students = students;
        let mut sandwiches = sandwiches;
        let mut count = [0, 0];
        for &s in &students {
            count[s as usize] += 1;
        }
        for &s in &sandwiches {
            if count[s as usize] == 0 {
                break;
            }
            count[s as usize] -= 1;
        }
        count[0] + count[1]
    }
}