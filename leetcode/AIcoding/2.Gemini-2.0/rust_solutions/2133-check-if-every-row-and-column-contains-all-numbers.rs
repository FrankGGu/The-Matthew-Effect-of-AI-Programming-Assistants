impl Solution {
    pub fn check_if_every_row_and_column_contains_all_numbers(matrix: Vec<Vec<i32>>) -> bool {
        let n = matrix.len();

        // Check rows
        for row in &matrix {
            let mut seen = std::collections::HashSet::new();
            for &num in row {
                if num < 1 || num as usize > n || seen.contains(&num) {
                    return false;
                }
                seen.insert(num);
            }
        }

        // Check columns
        for j in 0..n {
            let mut seen = std::collections::HashSet::new();
            for i in 0..n {
                let num = matrix[i][j];
                if num < 1 || num as usize > n || seen.contains(&num) {
                    return false;
                }
                seen.insert(num);
            }
        }

        true
    }
}