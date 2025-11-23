pub fn count_cells(s: String) -> Vec<i32> {
    let n = s.len();
    let mut counts = vec![0; n];
    let mut rows = vec![0; n];
    let mut cols = vec![0; n];

    for i in 0..n {
        for j in 0..n {
            if s.chars().nth(i).unwrap() == s.chars().nth(j).unwrap() {
                rows[i] += 1;
                cols[j] += 1;
            }
        }
    }

    for i in 0..n {
        counts[i] = rows[i] + cols[i] - 1;
    }

    counts
}