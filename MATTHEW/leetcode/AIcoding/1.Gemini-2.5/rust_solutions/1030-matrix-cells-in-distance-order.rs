impl Solution {
    pub fn all_cells_dist_order(r: i32, c: i32, r0: i32, c0: i32) -> Vec<Vec<i32>> {
        let mut cells_with_dist: Vec<(i32, Vec<i32>)> = Vec::new();

        for i in 0..r {
            for j in 0..c {
                let dist = (i - r0).abs() + (j - c0).abs();
                cells_with_dist.push((dist, vec![i, j]));
            }
        }

        cells_with_dist.sort_by_key(|k| k.0);

        cells_with_dist.into_iter().map(|(_, cell)| cell).collect()
    }
}