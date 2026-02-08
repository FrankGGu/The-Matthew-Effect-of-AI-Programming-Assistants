impl Solution {
    pub fn rename_columns(data: Vec<Vec<String>>, names: Vec<String>) -> Vec<Vec<String>> {
        let mut result = data;
        if !result.is_empty() && !names.is_empty() {
            result[0] = names;
        }
        result
    }
}