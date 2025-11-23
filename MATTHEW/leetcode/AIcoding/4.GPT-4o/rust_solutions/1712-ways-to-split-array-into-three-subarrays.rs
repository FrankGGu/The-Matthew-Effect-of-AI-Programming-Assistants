impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let total: i64 = nums.iter().map(|&x| x as i64).sum();
        let mut left_sum = 0;
        let mut count = 0;

        for i in 0..nums.len() - 2 {
            left_sum += nums[i] as i64;
            let mid_sum = total - left_sum;
            if left_sum >= mid_sum {
                count += 1;
            }
        }

        count
    }
}