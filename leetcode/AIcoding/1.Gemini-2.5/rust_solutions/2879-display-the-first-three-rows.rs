impl Solution {
    pub fn display_first_three_rows(data: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        data.into_iter().take(3).collect()
    }
}