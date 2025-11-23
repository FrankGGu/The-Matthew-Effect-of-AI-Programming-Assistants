impl Solution {
    pub fn count_beautiful_splits(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = vec![0; nums.len() + 1];

        for i in 0..nums.len() {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        for i in 1..nums.len() {
            let left_sum = prefix_sum[i];
            let right_sum = prefix_sum[nums.len()] - left_sum;

            if left_sum <= k * (i as i32) && right_sum <= k * ((nums.len() - i) as i32) {
                count += 1;
            }
        }

        count
    }
}