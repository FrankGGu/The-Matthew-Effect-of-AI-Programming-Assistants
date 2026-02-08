impl Solution {
    pub fn modify_columns(dataframe: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut df = dataframe;
        for row in df.iter_mut() {
            for num in row.iter_mut().skip(1).step_by(2) {
                *num *= 2;
            }
        }
        df
    }
}