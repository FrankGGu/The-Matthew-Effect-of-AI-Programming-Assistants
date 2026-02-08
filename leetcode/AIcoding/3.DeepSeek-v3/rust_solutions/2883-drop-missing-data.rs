impl Solution {
    pub fn drop_missing_data(frame: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut result = Vec::new();
        for row in frame {
            if !row.iter().any(|x| x.is_empty()) {
                result.push(row);
            }
        }
        result
    }
}