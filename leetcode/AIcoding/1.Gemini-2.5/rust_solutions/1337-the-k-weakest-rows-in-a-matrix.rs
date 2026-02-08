impl Solution {
    pub fn k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut row_strengths: Vec<(i32, i32)> = Vec::new();

        for (i, row) in mat.iter().enumerate() {
            let mut soldiers = 0;
            for &val in row {
                if val == 1 {
                    soldiers += 1;
                } else {
                    break; 
                }
            }
            row_strengths.push((soldiers, i as i32));
        }

        row_strengths.sort_unstable();

        row_strengths
            .into_iter()
            .take(k as usize)
            .map(|(_, index)| index)
            .collect()
    }
}