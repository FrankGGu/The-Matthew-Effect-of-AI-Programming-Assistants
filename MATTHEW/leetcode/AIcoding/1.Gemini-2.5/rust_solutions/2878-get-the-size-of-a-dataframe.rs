impl Solution {
    pub fn get_data_frame_size(df: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = df.len();
        let cols = if rows > 0 {
            df[0].len()
        } else {
            0
        };
        vec![rows as i32, cols as i32]
    }
}