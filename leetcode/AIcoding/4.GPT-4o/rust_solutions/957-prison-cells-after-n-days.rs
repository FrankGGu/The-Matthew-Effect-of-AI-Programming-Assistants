pub fn prison_after_n_days(cells: Vec<i32>, n: i32) -> Vec<i32> {
    let mut cells = cells;
    let n = n % 14; // Pattern repeats every 14 days
    for _ in 0..n {
        let mut next = vec![0; 8];
        for i in 1..7 {
            next[i] = if cells[i - 1] == cells[i + 1] { 1 } else { 0 };
        }
        cells = next;
    }
    cells
}