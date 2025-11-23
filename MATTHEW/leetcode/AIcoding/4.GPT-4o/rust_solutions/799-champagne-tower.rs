impl Solution {
    pub fn champagne_tower(poured: i32, query_row: i32, query_glass: i32) -> f64 {
        let mut tower = vec![vec![0.0; 100] for _ in 0..100];
        tower[0][0] = poured as f64;

        for r in 0..=query_row {
            for c in 0..=r {
                let overflow = (tower[r][c] - 1.0).max(0.0);
                if overflow > 0.0 {
                    tower[r][c] = 1.0;
                    if r + 1 < tower.len() {
                        tower[r + 1][c] += overflow / 2.0;
                        tower[r + 1][c + 1] += overflow / 2.0;
                    }
                }
            }
        }

        tower[query_row][query_glass].min(1.0)
    }
}