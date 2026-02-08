pub fn min_operations(grid: Vec<Vec<i32>>, x: i32) -> i32 {
    let mut nums: Vec<i32> = grid.iter().flat_map(|r| r.iter()).cloned().collect();
    nums.sort();
    let median = nums[nums.len() / 2];
    let mut ops = 0;

    for num in nums {
        if (num - median) % x != 0 {
            return -1;
        }
        ops += (num - median).abs() / x;
    }

    ops
}