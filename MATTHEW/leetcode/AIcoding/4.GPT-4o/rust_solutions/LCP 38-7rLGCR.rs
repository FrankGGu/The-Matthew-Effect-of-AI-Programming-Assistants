pub fn guard_castle(positions: Vec<Vec<i32>>) -> i32 {
    let mut max_count = 0;
    let mut row_count = vec![0; 100];
    let mut col_count = vec![0; 100];

    for pos in positions {
        let (x, y) = (pos[0] as usize, pos[1] as usize);
        row_count[x] += 1;
        col_count[y] += 1;
    }

    for pos in positions {
        let (x, y) = (pos[0] as usize, pos[1] as usize);
        max_count = max_count.max(row_count[x] + col_count[y] - 1);
    }

    max_count
}