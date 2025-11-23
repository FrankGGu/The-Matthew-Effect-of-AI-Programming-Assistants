impl Solution {
    pub fn min_operations(grid: Vec<Vec<i32>>, x: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut nums = Vec::new();
        for i in 0..m {
            for j in 0..n {
                nums.push(grid[i][j]);
            }
        }
        nums.sort();
        let median = nums[nums.len() / 2];
        let mut ans = 0;
        for &num in &nums {
            let diff = (num - median).abs();
            if diff % x != 0 {
                return -1;
            }
            ans += diff / x;
        }
        ans
    }
}