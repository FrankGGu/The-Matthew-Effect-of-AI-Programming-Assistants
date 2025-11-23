impl Solution {
    pub fn longest_v_shaped_diagonal(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_len = 0;

        for i in 0..m {
            for j in 0..n {
                for len in 1..=std::cmp::min(m, n) {
                    if i + 2 * len - 1 >= m || j - len + 1 < 0 || j + len - 1 >= n {
                        continue;
                    }

                    let mut is_v_shaped = true;
                    for k in 0..len - 1 {
                        if grid[i + k][j - k] >= grid[i + k + 1][j - k - 1] ||
                           grid[i + k][j + k] >= grid[i + k + 1][j + k + 1]
                        {
                            is_v_shaped = false;
                            break;
                        }
                    }
                     if grid[i + len - 1][j - len + 1] >= grid[i + len][j - len] ||
                           grid[i + len - 1][j + len - 1] >= grid[i + len][j + len]
                        {
                            is_v_shaped = false;
                            break;
                        }

                    for k in len..2 * len - 1 {
                         if grid[i + k][j - (2*len -1 - k)] <= grid[i + k + 1][j - (2*len - k)] ||
                           grid[i + k][j + (2*len -1 - k)] <= grid[i + k + 1][j + (2*len - k)]
                        {
                            is_v_shaped = false;
                            break;
                        }
                    }

                    if is_v_shaped {
                        max_len = std::cmp::max(max_len, len as i32 * 2 - 1);
                    }
                }
            }
        }

        max_len
    }
}