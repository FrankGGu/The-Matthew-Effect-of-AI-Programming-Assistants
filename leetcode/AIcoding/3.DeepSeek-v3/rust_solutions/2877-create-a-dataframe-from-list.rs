impl Solution {
    pub fn create_dataframe(student_data: Vec<Vec<i32>>) -> pandas::DataFrame {
        let mut df = pandas::DataFrame::new();
        df.insert("student_id", student_data.iter().map(|v| v[0]).collect());
        df.insert("age", student_data.iter().map(|v| v[1]).collect());
        df
    }
}