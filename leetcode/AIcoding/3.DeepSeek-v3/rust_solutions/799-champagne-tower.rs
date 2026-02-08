impl Solution {
    pub fn champagne_tower(poured: i32, query_row: i32, query_glass: i32) -> f64 {
        let mut tower = vec![vec![0.0; 100]; 100];
        tower[0][0] = poured as f64;
        for i in 0..query_row as usize {
            for j in 0..=i {
                let excess = (tower[i][j] - 1.0).max(0.0);
                if excess > 0.0 {
                    tower[i + 1][j] += excess / 2.0;
                    tower[i + 1][j + 1] += excess / 2.0;
                }
            }
        }
        tower[query_row as usize][query_glass as usize].min(1.0)
    }
}