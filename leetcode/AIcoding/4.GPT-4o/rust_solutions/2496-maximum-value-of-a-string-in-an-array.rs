impl Solution {
    pub fn maximum_value(strs: Vec<String>) -> i32 {
        strs.iter()
            .map(|s| {
                if s.chars().all(char::is_numeric) {
                    s.parse::<i32>().unwrap()
                } else {
                    s.len() as i32
                }
            })
            .max()
            .unwrap_or(0)
    }
}