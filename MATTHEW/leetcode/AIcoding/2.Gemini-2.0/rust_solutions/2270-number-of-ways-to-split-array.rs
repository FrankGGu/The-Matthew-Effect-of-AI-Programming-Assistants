impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut count = 0;
        for i in 0..n - 1 {
            if prefix_sum[i + 1] >= prefix_sum[n] - prefix_sum[i + 1] {
                count += 1;
            }
        }

        count
    }
}