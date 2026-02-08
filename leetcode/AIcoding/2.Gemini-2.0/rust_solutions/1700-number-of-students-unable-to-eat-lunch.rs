impl Solution {
    pub fn count_students(students: Vec<i32>, sandwiches: Vec<i32>) -> i32 {
        let mut students = students;
        let mut sandwiches = sandwiches;
        let mut count = 0;
        let mut i = 0;
        while i < students.len() && count < students.len() {
            if students[0] == sandwiches[0] {
                students.remove(0);
                sandwiches.remove(0);
                count = 0;
                i = 0;
            } else {
                let temp = students.remove(0);
                students.push(temp);
                count += 1;
                i += 1;
            }
        }
        students.len() as i32
    }
}