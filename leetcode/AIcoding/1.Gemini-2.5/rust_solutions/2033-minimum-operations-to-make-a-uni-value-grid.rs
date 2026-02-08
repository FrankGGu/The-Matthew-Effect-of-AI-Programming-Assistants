impl Solution {
    pub fn min_operations(grid: Vec<Vec<i32>>, x: i32) -> i32 {
        let mut nums: Vec<i32> = grid.into_iter().flat_map(|row| row.into_iter()).collect();

        let first_rem = nums[0] % x;
        for &num in &nums {
            if num % x != first_rem {
                return -1;
            }
        }

        nums.sort_unstable();

        let median_val = nums[nums.len() / 2];
        let mut operations: i32 = 0;

        for &num in &nums {
            operations += (num - median_val).abs() / x;
        }

        operations
    }
}