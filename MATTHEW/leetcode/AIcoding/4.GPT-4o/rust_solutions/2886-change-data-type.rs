impl Solution {
    pub fn change_data_type(data: Vec<String>) -> Vec<i32> {
        data.into_iter().map(|s| s.parse::<i32>().unwrap()).collect()
    }
}