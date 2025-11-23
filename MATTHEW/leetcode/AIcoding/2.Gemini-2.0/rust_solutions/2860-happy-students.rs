impl Solution {
    pub fn happy_students(students: Vec<i32>) -> i32 {
        let mut students = students;
        students.sort();
        let n = students.len();
        let mut count = 0;
        for i in 0..n {
            if students[i] <= (i + 1) as i32 {
                if i == n - 1 || students[i + 1] > (i + 1) as i32 {
                    count += 1;
                }
            }
        }
        count
    }
}