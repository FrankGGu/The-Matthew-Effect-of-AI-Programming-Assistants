impl Solution {
    pub fn get_row(row_index: i32) -> Vec<i32> {
        let mut row: Vec<i32> = vec![1];
        if row_index == 0 {
            return row;
        }

        for i in 1..=row_index {
            let mut next_row: Vec<i32> = vec![1; (i + 1) as usize];
            for j in 1..i {
                next_row[j as usize] = row[(j - 1) as usize] + row[j as usize];
            }
            row = next_row;
        }

        row
    }
}