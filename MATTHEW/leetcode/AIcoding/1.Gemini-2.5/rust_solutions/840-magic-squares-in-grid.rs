impl Solution {
    pub fn num_magic_squares_in_grid(grid: Vec<Vec<i32>>) -> i32 {
        let r_len = grid.len();
        if r_len < 3 {
            return 0;
        }
        let c_len = grid[0].len();
        if c_len < 3 {
            return 0;
        }

        let mut count = 0;

        for r in 0..=r_len - 3 {
            for c in 0..=c_len - 3 {
                if Solution::is_magic_square(r, c, &grid) {
                    count += 1;
                }
            }
        }
        count
    }

    fn is_magic_square(r_start: usize, c_start: usize, grid: &Vec<Vec<i32>>) -> bool {
        let mut seen = [false; 10]; // For numbers 1-9
        let mut nums = Vec::with_capacity(9);

        for i in 0..3 {
            for j in 0..3 {
                let num = grid[r_start + i][c_start + j];
                if num < 1 || num > 9 || seen[num as usize] {
                    return false;
                }
                seen[num as usize] = true;
                nums.push(num);
            }
        }

        // Check sums (all must be 15 for a 3x3 magic square with numbers 1-9)
        // Rows
        if nums[0] + nums[1] + nums[2] != 15 { return false; }
        if nums[3] + nums[4] + nums[5] != 15 { return false; }
        if nums[6] + nums[7] + nums[8] != 15 { return false; }
        // Columns
        if nums[0] + nums[3] + nums[6] != 15 { return false; }
        if nums[1] + nums[4] + nums[7] != 15 { return false; }
        if nums[2] + nums[5] + nums[8] != 15 { return false; }
        // Diagonals
        if nums[0] + nums[4] + nums[8] != 15 { return false; }
        if nums[2] + nums[4] + nums[6] != 15 { return false; }

        true
    }
}