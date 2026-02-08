struct Solution;

impl Solution {
    pub fn tiling_rectangle(n: i32, m: i32) -> i32 {
        let n_usize = n as usize;
        let m_usize = m as usize;

        let mut min_squares = n * m;

        let mut grid: Vec<u16> = vec![0; n_usize];

        Self::dfs(0, &mut grid, n_usize, m_usize, &mut min_squares);

        min_squares
    }

    fn find_empty_cell(grid: &Vec<u16>, n: usize, m: usize) -> Option<(usize, usize)> {
        for r in 0..n {
            for c in 0..m {
                if (grid[r] >> c) & 1 == 0 {
                    return Some((r, c));
                }
            }
        }
        None
    }

    fn can_place(grid: &Vec<u16>, r: usize, c: usize, s: usize, n: usize, m: usize) -> bool {
        if r + s > n || c + s > m {
            return false;
        }
        for i in r..r + s {
            for j in c..c + s {
                if (grid[i] >> j) & 1 == 1 {
                    return false;
                }
            }
        }
        true
    }

    fn fill_square(grid: &mut Vec<u16>, r: usize, c: usize, s: usize) {
        for i in r..r + s {
            for j in c..c + s {
                grid[i] |= 1 << j;
            }
        }
    }

    fn unfill_square(grid: &mut Vec<u16>, r: usize, c: usize, s: usize) {
        for i in r..r + s {
            for j in c..c + s {
                grid[i] &= !(1 << j);
            }
        }
    }

    fn dfs(
        count: i32,
        grid: &mut Vec<u16>,
        n: usize,
        m: usize,
        min_squares: &mut i32,
    ) {
        if count >= *min_squares {
            return;
        }

        let Some((r, c)) = Self::find_empty_cell(grid, n, m) else {
            *min_squares = count.min(*min_squares);
            return;
        };

        for s in (1..=(n - r).min(m - c)).rev() {
            if Self::can_place(grid, r, c, s, n, m) {
                Self::fill_square(grid, r, c, s);
                Self::dfs(count + 1, grid, n, m, min_squares);
                Self::unfill_square(grid, r, c, s);
            }
        }
    }
}