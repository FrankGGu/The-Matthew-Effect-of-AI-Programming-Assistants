impl Solution {
    pub fn generate(num_rows: i32) -> Vec<Vec<i32>> {
        let mut triangle: Vec<Vec<i32>> = Vec::new();

        for i in 0..num_rows as usize {
            let mut current_row: Vec<i32> = vec![0; i + 1];
            current_row[0] = 1;
            current_row[i] = 1;

            if i > 1 {
                let prev_row = &triangle[i - 1];
                for j in 1..i {
                    current_row[j] = prev_row[j - 1] + prev_row[j];
                }
            }
            triangle.push(current_row);
        }

        triangle
    }
}