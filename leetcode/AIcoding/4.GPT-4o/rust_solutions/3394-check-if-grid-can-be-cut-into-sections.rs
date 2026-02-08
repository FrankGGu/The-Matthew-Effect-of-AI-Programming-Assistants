impl Solution {
    pub fn can_cut(grid: Vec<Vec<i32>>) -> bool {
        let (m, n) = (grid.len(), grid[0].len());
        let mut total = 0;
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                total += grid[i][j];
            }
        }

        if total % 3 != 0 {
            return false;
        }

        let target = total / 3;
        let mut current_sum = 0;

        for i in 0..m {
            for j in 0..n {
                current_sum += grid[i][j];
                if current_sum == target {
                    current_sum = 0;
                    count += 1;
                } else if current_sum > target {
                    return false;
                }
            }
        }

        count >= 3
    }
}