impl Solution {
    pub fn matrix_rank_transform(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        use std::collections::HashMap;
        let (m, n) = (matrix.len(), matrix[0].len());
        let mut value_positions = vec![];

        for i in 0..m {
            for j in 0..n {
                value_positions.push((matrix[i][j], i, j));
            }
        }

        value_positions.sort_unstable();

        let mut rank = vec![vec![0; n]; m];
        let mut row_ranks = vec![0; m];
        let mut col_ranks = vec![0; n];
        let mut last_value = i32::MIN;

        for (value, i, j) in value_positions {
            if value != last_value {
                row_ranks.iter_mut().for_each(|r| *r = 0);
                col_ranks.iter_mut().for_each(|r| *r = 0);
            }

            let row_rank = row_ranks[i];
            let col_rank = col_ranks[j];
            let current_rank = row_rank.max(col_rank) + 1;

            rank[i][j] = current_rank;
            row_ranks[i] = current_rank;
            col_ranks[j] = current_rank;

            last_value = value;
        }

        rank
    }
}