impl Solution {
    pub fn get_biggest_three(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut sums = std::collections::BTreeSet::new();

        for i in 0..m {
            for j in 0..n {
                sums.insert(grid[i][j]);
                let max_k = (i.min(m - 1 - i).min(j.min(n - 1 - j))) as i32;
                for k in 1..=max_k {
                    let mut sum = 0;
                    let mut x = i as i32 - k;
                    let mut y = j;
                    for _ in 0..k {
                        sum += grid[x as usize][y];
                        x += 1;
                        y += 1;
                    }
                    for _ in 0..k {
                        sum += grid[x as usize][y];
                        x += 1;
                        y -= 1;
                    }
                    for _ in 0..k {
                        sum += grid[x as usize][y];
                        x -= 1;
                        y -= 1;
                    }
                    for _ in 0..k {
                        sum += grid[x as usize][y];
                        x -= 1;
                        y += 1;
                    }
                    sums.insert(sum);
                }
            }
        }

        let mut res: Vec<i32> = sums.into_iter().rev().take(3).collect();
        res.sort_unstable_by(|a, b| b.cmp(a));
        res
    }
}