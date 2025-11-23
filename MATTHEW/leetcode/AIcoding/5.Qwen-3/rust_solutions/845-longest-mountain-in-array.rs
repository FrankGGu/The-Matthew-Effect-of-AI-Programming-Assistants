pub fn longest_mountain(nums: Vec<i32>) -> i32 {
    let n = nums.len();
    if n < 3 {
        return 0;
    }

    let mut max_length = 0;
    let mut i = 1;

    while i < n - 1 {
        let mut up = 0;
        let mut down = 0;

        // Check for up
        while i < n - 1 && nums[i] > nums[i - 1] {
            i += 1;
            up += 1;
        }

        // Check for down
        while i < n - 1 && nums[i] < nums[i - 1] {
            i += 1;
            down += 1;
        }

        if up > 0 && down > 0 {
            max_length = std::cmp::max(max_length, up + down + 1);
        } else {
            i += 1;
        }
    }

    max_length
}