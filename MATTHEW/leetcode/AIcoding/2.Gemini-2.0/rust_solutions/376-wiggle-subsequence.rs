impl Solution {
    pub fn wiggle_max_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return n as i32;
        }

        let mut up = 1;
        let mut down = 1;

        for i in 1..n {
            if nums[i] > nums[i - 1] {
                up = down + 1;
            } else if nums[i] < nums[i - 1] {
                down = up + 1;
            }
        }

        up.max(down) as i32
    }
}