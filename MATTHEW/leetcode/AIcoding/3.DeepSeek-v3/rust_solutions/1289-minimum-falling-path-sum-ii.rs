impl Solution {
    pub fn min_falling_path_sum(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 1 {
            return grid[0][0];
        }

        let mut dp_prev = grid[0].clone();
        for i in 1..n {
            let mut dp_curr = vec![0; n];
            let (min1, min2) = Self::find_two_mins(&dp_prev);
            for j in 0..n {
                if dp_prev[j] == min1 {
                    dp_curr[j] = grid[i][j] + min2;
                } else {
                    dp_curr[j] = grid[i][j] + min1;
                }
            }
            dp_prev = dp_curr;
        }

        *dp_prev.iter().min().unwrap()
    }

    fn find_two_mins(arr: &[i32]) -> (i32, i32) {
        let mut min1 = i32::MAX;
        let mut min2 = i32::MAX;
        for &num in arr {
            if num < min1 {
                min2 = min1;
                min1 = num;
            } else if num < min2 {
                min2 = num;
            }
        }
        (min1, min2)
    }
}