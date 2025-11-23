impl Solution {
    pub fn shift_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let total = m * n;
        let k = (k as usize) % total;
        let mut flat: Vec<i32> = grid.into_iter().flatten().collect();
        flat.rotate_right(k);
        flat.chunks(n).map(|row| row.to_vec()).collect()
    }
}