impl Solution {
    pub fn shift_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let k = k as usize % (m * n);
        let mut v: Vec<i32> = grid.iter().flat_map(|row| row.iter().cloned()).collect();
        let mut shifted = v.split_off(v.len() - k);
        shifted.extend(v);
        let mut result: Vec<Vec<i32>> = Vec::new();
        for i in 0..m {
            result.push(shifted[i * n..(i + 1) * n].to_vec());
        }
        result
    }
}