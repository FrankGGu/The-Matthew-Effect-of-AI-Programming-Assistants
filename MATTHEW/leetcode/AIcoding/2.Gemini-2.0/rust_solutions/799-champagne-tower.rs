impl Solution {
    pub fn champagne_tower(poured: i32, query_row: i32, query_glass: i32) -> f64 {
        let poured = poured as f64;
        let query_row = query_row as usize;
        let query_glass = query_glass as usize;

        let mut tower: Vec<Vec<f64>> = vec![vec![0.0; query_row + 2]; query_row + 2];
        tower[0][0] = poured;

        for r in 0..query_row + 1 {
            for c in 0..=r {
                if tower[r][c] > 1.0 {
                    let overflow = (tower[r][c] - 1.0) / 2.0;
                    tower[r][c] = 1.0;
                    tower[r + 1][c] += overflow;
                    tower[r + 1][c + 1] += overflow;
                }
            }
        }

        tower[query_row][query_glass].min(1.0)
    }
}