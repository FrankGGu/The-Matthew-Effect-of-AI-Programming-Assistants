struct Solution;

impl Solution {
    pub fn possible_to_stamp(grid: Vec<Vec<char>>, stamp: Vec<Vec<char>>) -> bool {
        let (h, w) = (grid.len(), grid[0].len());
        let (sh, sw) = (stamp.len(), stamp[0].len());

        if sh > h || sw > w {
            return false;
        }

        let mut pattern = vec![vec![0; w]; h];

        for i in 0..h {
            for j in 0..w {
                if grid[i][j] == '1' {
                    for di in 0..sh {
                        for dj in 0..sw {
                            let ni = i + di;
                            let nj = j + dj;
                            if ni < h && nj < w {
                                pattern[ni][nj] += 1;
                            }
                        }
                    }
                }
            }
        }

        for i in 0..h {
            for j in 0..w {
                if grid[i][j] == '1' && pattern[i][j] == 0 {
                    return false;
                }
            }
        }

        true
    }
}