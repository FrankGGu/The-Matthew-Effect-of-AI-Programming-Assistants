impl Solution {
    pub fn select_data(student: Vec<Vec<String>>) -> Vec<Vec<String>> {
        student.into_iter().filter(|s| s[2] == "Math").collect()
    }
}