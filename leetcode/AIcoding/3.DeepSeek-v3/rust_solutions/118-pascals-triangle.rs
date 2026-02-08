impl Solution {
    pub fn generate(num_rows: i32) -> Vec<Vec<i32>> {
        let num_rows = num_rows as usize;
        let mut triangle: Vec<Vec<i32>> = Vec::with_capacity(num_rows);

        for i in 0..num_rows {
            let mut row = vec![1; i + 1];
            for j in 1..i {
                row[j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
            }
            triangle.push(row);
        }

        triangle
    }
}