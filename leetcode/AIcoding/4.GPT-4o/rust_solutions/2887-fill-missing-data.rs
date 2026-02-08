impl Solution {
    pub fn fill_missing_data(data: Vec<Option<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut last_valid = None;

        for &value in &data {
            match value {
                Some(v) => {
                    result.push(v);
                    last_valid = Some(v);
                }
                None => {
                    if let Some(last) = last_valid {
                        result.push(last);
                    }
                }
            }
        }

        result
    }
}