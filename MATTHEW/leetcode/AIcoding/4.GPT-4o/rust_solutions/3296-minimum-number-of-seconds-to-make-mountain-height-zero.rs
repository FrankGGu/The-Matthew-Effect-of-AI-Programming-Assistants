impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_time = 0;
        let mut max_height = *nums.iter().max().unwrap();

        for &h in &nums {
            total_time += max_height - h;
        }

        total_time / 2 + total_time % 2
    }
}