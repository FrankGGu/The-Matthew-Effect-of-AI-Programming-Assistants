impl Solution {
    pub fn first_three(rows: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        rows.into_iter().take(3).collect()
    }
}