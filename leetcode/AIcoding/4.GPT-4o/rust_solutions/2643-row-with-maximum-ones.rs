impl Solution {
    pub fn row_and_max_ones(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let mut max_row = 0;
        let mut max_count = 0;

        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().sum::<i32>();
            if count > max_count {
                max_count = count;
                max_row = i;
            }
        }

        vec![max_row as i32, max_count]
    }
}