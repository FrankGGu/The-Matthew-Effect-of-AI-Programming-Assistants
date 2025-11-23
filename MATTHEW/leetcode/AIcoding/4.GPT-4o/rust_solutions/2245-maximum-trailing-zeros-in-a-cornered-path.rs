impl Solution {
    pub fn max_trailing_zeros(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut max_zeros = 0;

        for i in 0..n {
            for j in 0..m {
                let mut count_2 = 0;
                let mut count_5 = 0;
                for x in 0..=i {
                    for y in 0..=j {
                        let mut num = grid[x][y];
                        while num % 2 == 0 {
                            count_2 += 1;
                            num /= 2;
                        }
                        num = grid[x][y];
                        while num % 5 == 0 {
                            count_5 += 1;
                            num /= 5;
                        }
                    }
                }
                max_zeros = max_zeros.max(count_2.min(count_5));
            }
        }
        max_zeros
    }
}