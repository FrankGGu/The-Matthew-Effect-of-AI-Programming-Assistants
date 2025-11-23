impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut res = std::i32::MAX;

        for mask in 0..(1 << n) {
            let mut flips = 0;
            let mut valid = true;

            for i in 0..n {
                for j in 0..n {
                    let expected = ((mask >> i) & 1) ^ ((mask >> j) & 1);
                    if grid[i][j] != expected {
                        flips += 1;
                    }
                }
            }

            if valid {
                res = res.min(flips);
            }
        }

        res
    }
}