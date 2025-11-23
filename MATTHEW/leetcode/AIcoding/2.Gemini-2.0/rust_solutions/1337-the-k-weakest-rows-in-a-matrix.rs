impl Solution {
    pub fn k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut rows: Vec<(i32, i32)> = mat
            .iter()
            .enumerate()
            .map(|(i, row)| {
                let strength = row.iter().sum::<i32>();
                (strength, i as i32)
            })
            .collect();

        rows.sort();

        rows.iter().take(k as usize).map(|&(_, i)| i).collect()
    }
}