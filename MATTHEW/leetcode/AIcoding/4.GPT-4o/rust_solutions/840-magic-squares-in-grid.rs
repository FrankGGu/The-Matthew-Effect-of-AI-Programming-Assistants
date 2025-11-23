impl Solution {
    pub fn num_magic_squares_inside(grid: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;

        for i in 0..(grid.len() - 2) {
            for j in 0..(grid[0].len() - 2) {
                let mut nums = vec![];
                for x in i..i + 3 {
                    for y in j..j + 3 {
                        nums.push(grid[x][y]);
                    }
                }
                if Self::is_magic_square(&nums) {
                    count += 1;
                }
            }
        }

        count
    }

    fn is_magic_square(nums: &Vec<i32>) -> bool {
        let magic_sum = 15;
        let rows: [i32; 3] = [nums[0] + nums[1] + nums[2], nums[3] + nums[4] + nums[5], nums[6] + nums[7] + nums[8]];
        let cols: [i32; 3] = [nums[0] + nums[3] + nums[6], nums[1] + nums[4] + nums[7], nums[2] + nums[5] + nums[8]];
        let diag1 = nums[0] + nums[4] + nums[8];
        let diag2 = nums[2] + nums[4] + nums[6];

        let unique: std::collections::HashSet<_> = nums.iter().collect();
        unique.len() == 9 && unique.iter().all(|&x| x >= 1 && x <= 9) && 
        rows.iter().all(|&x| x == magic_sum) && 
        cols.iter().all(|&x| x == magic_sum) && 
        diag1 == magic_sum && diag2 == magic_sum
    }
}