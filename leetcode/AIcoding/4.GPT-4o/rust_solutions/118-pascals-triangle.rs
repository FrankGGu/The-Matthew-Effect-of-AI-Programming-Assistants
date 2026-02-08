impl Solution {
    pub fn generate(num_rows: i32) -> Vec<Vec<i32>> {
        let mut triangle = vec![];
        for i in 0..num_rows {
            let mut row = vec![1; (i + 1) as usize];
            for j in 1..i {
                row[j as usize] = triangle[i as usize - 1][j as usize - 1] + triangle[i as usize - 1][j as usize];
            }
            triangle.push(row);
        }
        triangle
    }
}