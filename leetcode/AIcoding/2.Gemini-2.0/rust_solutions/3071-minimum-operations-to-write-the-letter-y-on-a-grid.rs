impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut count0 = [0; 3];
        let mut count1 = [0; 3];

        for i in 0..n {
            for j in 0..n {
                let group = if (i == j) || (i + j == n - 1) { 1 } else { 0 };
                let val = grid[i][j] as usize;
                if group == 0 {
                    count0[val] += 1;
                } else {
                    count1[val] += 1;
                }
            }
        }

        let total0 = n * n - (2 * n - 1);
        let total1 = 2 * n - 1;

        let mut ans = i32::MAX;
        for i in 0..3 {
            for j in 0..3 {
                if i != j {
                    ans = ans.min((total0 - count0[i]) + (total1 - count1[j]));
                }
            }
        }

        ans as i32
    }
}