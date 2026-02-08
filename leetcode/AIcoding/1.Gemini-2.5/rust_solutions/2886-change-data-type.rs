impl Solution {
    pub fn change_data_type(s: String) -> Option<i32> {
        s.parse::<i32>().ok()
    }
}