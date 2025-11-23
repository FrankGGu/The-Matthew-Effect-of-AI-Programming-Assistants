impl Solution {
    pub fn generate(num_rows: i32) -> Vec<Vec<i32>> {
        let mut triangle: Vec<Vec<i32>> = Vec::new();

        for i in 0..num_rows {
            let mut row: Vec<i32> = Vec::new();
            for j in 0..=i {
                if j == 0 || j == i {
                    row.push(1);
                } else {
                    let prev_row = &triangle[(i - 1) as usize];
                    row.push(prev_row[(j - 1) as usize] + prev_row[j as usize]);
                }
            }
            triangle.push(row);
        }

        triangle
    }
}