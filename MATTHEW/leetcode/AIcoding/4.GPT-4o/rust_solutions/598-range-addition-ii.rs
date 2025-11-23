pub fn max_count(m: i32, n: i32, ops: Vec<Vec<i32>>) -> i32 {
    let mut rows = m;
    let mut cols = n;
    for op in ops {
        rows = rows.min(op[0]);
        cols = cols.min(op[1]);
    }
    rows * cols
}