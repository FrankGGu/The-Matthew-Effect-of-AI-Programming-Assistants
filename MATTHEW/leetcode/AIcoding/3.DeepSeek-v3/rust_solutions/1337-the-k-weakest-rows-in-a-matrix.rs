impl Solution {
    pub fn k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut rows: Vec<(i32, usize)> = mat.iter()
            .enumerate()
            .map(|(i, row)| (row.iter().sum(), i))
            .collect();
        rows.sort();
        rows.iter()
            .take(k as usize)
            .map(|&(_, i)| i as i32)
            .collect()
    }
}