pub fn drop_missing_data(data: Vec<Vec<Option<i32>>>) -> Vec<Vec<i32>> {
    let rows = data.len();
    let cols = data[0].len();
    let mut valid_rows = vec![true; rows];
    let mut valid_cols = vec![true; cols];

    for i in 0..rows {
        for j in 0..cols {
            if data[i][j].is_none() {
                valid_rows[i] = false;
                valid_cols[j] = false;
            }
        }
    }

    let mut result = Vec::new();
    for i in 0..rows {
        if valid_rows[i] {
            let mut row = Vec::new();
            for j in 0..cols {
                if valid_cols[j] {
                    row.push(data[i][j].unwrap());
                }
            }
            result.push(row);
        }
    }

    result
}