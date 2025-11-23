impl Solution {
    pub fn find_students(content: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for row in content {
            if row[1] > row[0] {
                result.push(row[2]);
            }
        }
        result
    }
}