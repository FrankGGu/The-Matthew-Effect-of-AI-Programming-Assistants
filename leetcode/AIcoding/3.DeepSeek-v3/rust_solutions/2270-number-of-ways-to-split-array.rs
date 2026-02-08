impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let total: i64 = nums.iter().map(|&x| x as i64).sum();
        let mut prefix_sum: i64 = 0;
        let mut count = 0;

        for i in 0..nums.len() - 1 {
            prefix_sum += nums[i] as i64;
            if prefix_sum >= total - prefix_sum {
                count += 1;
            }
        }

        count
    }
}