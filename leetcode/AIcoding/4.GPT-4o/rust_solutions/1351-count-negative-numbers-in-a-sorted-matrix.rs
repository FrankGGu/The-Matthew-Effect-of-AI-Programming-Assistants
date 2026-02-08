impl Solution {
    pub fn count_negatives(grid: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        for row in grid.iter() {
            for &num in row.iter() {
                if num < 0 {
                    count += 1;
                }
            }
        }
        count
    }
}