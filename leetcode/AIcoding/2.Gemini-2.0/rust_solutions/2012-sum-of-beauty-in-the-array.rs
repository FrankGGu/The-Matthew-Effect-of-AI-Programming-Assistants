impl Solution {
    pub fn sum_of_beauty(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_max = vec![0; n];
        let mut right_min = vec![0; n];

        left_max[0] = nums[0];
        for i in 1..n {
            left_max[i] = std::cmp::max(left_max[i - 1], nums[i]);
        }

        right_min[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            right_min[i] = std::cmp::min(right_min[i + 1], nums[i]);
        }

        let mut beauty_sum = 0;
        for i in 1..n - 1 {
            if nums[i] > left_max[i - 1] && nums[i] < right_min[i + 1] {
                beauty_sum += 2;
            } else if nums[i] > nums[i - 1] && nums[i] < nums[i + 1] {
                beauty_sum += 1;
            }
        }

        beauty_sum
    }
}