struct Solution;

impl Solution {
    pub fn row_with_max_ones(mat: Vec<Vec<i32>>) -> i32 {
        let mut max_row = -1;
        let mut max_count = 0;

        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().filter(|&&x| x == 1).count();
            if count > max_count {
                max_count = count;
                max_row = i as i32;
            }
        }

        max_row
    }
}