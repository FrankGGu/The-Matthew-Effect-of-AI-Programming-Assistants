impl Solution {
    pub fn check_valid_grid(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let mut positions = vec![(0, 0); n * n];

        for i in 0..n {
            for j in 0..n {
                let num = grid[i][j] as usize;
                positions[num] = (i as i32, j as i32);
            }
        }

        if positions[0] != (0, 0) {
            return false;
        }

        for i in 1..positions.len() {
            let (x1, y1) = positions[i - 1];
            let (x2, y2) = positions[i];
            let dx = (x1 - x2).abs();
            let dy = (y1 - y2).abs();
            if !((dx == 1 && dy == 2) || (dx == 2 && dy == 1)) {
                return false;
            }
        }

        true
    }
}