impl Solution {
    pub fn row_and_maximum_ones(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let mut max_ones = -1;
        let mut max_row = -1;

        for (i, row) in mat.iter().enumerate() {
            let ones = row.iter().filter(|&x| *x == 1).count() as i32;
            if ones > max_ones {
                max_ones = ones;
                max_row = i as i32;
            }
        }

        vec![max_row, max_ones]
    }
}