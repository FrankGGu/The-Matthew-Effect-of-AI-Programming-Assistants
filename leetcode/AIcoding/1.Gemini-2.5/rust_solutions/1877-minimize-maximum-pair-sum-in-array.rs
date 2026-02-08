impl Solution {
    pub fn min_max_pair_sum(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut max_pair_sum = 0;
        for i in 0..n / 2 {
            let current_pair_sum = nums[i] + nums[n - 1 - i];
            if current_pair_sum > max_pair_sum {
                max_pair_sum = current_pair_sum;
            }
        }
        max_pair_sum
    }
}