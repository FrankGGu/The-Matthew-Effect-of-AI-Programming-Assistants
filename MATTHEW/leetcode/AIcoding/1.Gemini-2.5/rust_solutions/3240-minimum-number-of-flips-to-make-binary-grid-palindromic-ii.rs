impl Solution {
    pub fn minimum_flips(grid: Vec<Vec<i32>>) -> i32 {
        let r = grid.len();
        let c = grid[0].len();
        let mut flips = 0;

        for i in 0..r {
            for j in 0..c {
                let sym_i = r - 1 - i;
                let sym_j = c - 1 - j;

                // We only need to consider each unique pair of symmetric cells once.
                // A cell (i, j) and its symmetric counterpart (sym_i, sym_j) form a pair.
                // To avoid double-counting and correctly handle center elements,
                // we process the pair only if (i, j) comes "before" (sym_i, sym_j)
                // in lexicographical order.
                if i < sym_i || (i == sym_i && j < sym_j) {
                    if grid[i][j] != grid[sym_i][sym_j] {
                        flips += 1;
                    }
                }
            }
        }

        flips
    }
}