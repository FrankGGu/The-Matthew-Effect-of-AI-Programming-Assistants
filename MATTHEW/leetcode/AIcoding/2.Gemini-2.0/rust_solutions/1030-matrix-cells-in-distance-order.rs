impl Solution {
    pub fn all_cells_dist_order(r: i32, c: i32, r0: i32, c0: i32) -> Vec<Vec<i32>> {
        let mut cells: Vec<Vec<i32>> = Vec::new();
        for i in 0..r {
            for j in 0..c {
                cells.push(vec![i, j]);
            }
        }

        cells.sort_by_key(|cell| (cell[0] - r0).abs() + (cell[1] - c0).abs());
        cells
    }
}