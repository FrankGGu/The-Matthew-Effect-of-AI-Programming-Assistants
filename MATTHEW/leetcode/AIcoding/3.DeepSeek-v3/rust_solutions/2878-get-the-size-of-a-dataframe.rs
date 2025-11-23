impl Solution {
    pub fn get_size(df: Vec<Vec<String>>) -> Vec<i32> {
        let rows = df.len() as i32;
        let cols = if rows > 0 { df[0].len() as i32 } else { 0 };
        vec![rows, cols]
    }
}