impl Solution {
    pub fn row_and_maximum_ones(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let mut max_row = 0;
        let mut max_count = 0;

        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().filter(|&&x| x == 1).count() as i32;
            if count > max_count {
                max_count = count;
                max_row = i as i32;
            }
        }

        vec![max_row, max_count]
    }
}