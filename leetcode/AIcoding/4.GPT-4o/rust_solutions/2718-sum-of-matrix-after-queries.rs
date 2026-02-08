pub fn matrix_sum_after_queries(mat: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut sum = mat.iter().flat_map(|row| row.iter()).sum::<i32>();
    let mut row_additions = vec![0; mat.len()];
    let mut col_additions = vec![0; mat[0].len()];

    for query in queries {
        let (row, col, add) = (query[1] as usize, query[2] as usize, query[0]);
        sum += add - row_additions[row] + (col_additions[col] * mat[row].len() as i32);
        row_additions[row] += add;
        col_additions[col] += add;
        result.push(sum);
    }

    result
}