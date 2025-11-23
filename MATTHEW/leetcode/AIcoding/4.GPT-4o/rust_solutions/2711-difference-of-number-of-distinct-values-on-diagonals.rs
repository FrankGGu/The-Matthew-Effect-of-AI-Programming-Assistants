impl Solution {
    pub fn difference_of_distinct_values(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = vec![vec![0; mat[0].len()]; mat.len()];

        for i in 0..mat.len() {
            for j in 0..mat[i].len() {
                let mut left_diagonal = std::collections::HashSet::new();
                let mut right_diagonal = std::collections::HashSet::new();

                let mut x = i;
                let mut y = j;
                while x < mat.len() && y < mat[0].len() {
                    left_diagonal.insert(mat[x][y]);
                    x += 1;
                    y += 1;
                }

                x = i;
                y = j;
                while x < mat.len() && y >= 0 {
                    right_diagonal.insert(mat[x][y]);
                    x += 1;
                    y -= 1;
                }

                result[i][j] = (left_diagonal.len() as i32 - right_diagonal.len() as i32).abs();
            }
        }

        result
    }
}