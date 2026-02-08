impl Solution {
    pub fn count_submatrices_with_equal_x_y(matrix: Vec<Vec<char>>, x: char, y: char) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut count = 0;

        for top in 0..m {
            let mut freq = vec![0; n];
            for bottom in top..m {
                for col in 0..n {
                    if matrix[bottom][col] == x {
                        freq[col] += 1;
                    } else if matrix[bottom][col] == y {
                        freq[col] -= 1;
                    }
                }

                let mut map = std::collections::HashMap::new();
                map.insert(0, 1);
                let mut sum = 0;
                for &f in &freq {
                    sum += f;
                    count += *map.get(&sum).unwrap_or(&0);
                    *map.entry(sum).or_insert(0) += 1;
                }
            }
        }
        count
    }
}