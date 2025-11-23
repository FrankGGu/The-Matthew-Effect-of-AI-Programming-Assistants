impl Solution {
    pub fn min_positive_sum_subarray(nums: Vec<i32>) -> i32 {
        let mut min_sum = i32::MAX;
        let mut prefix_sum = 0;
        let mut max_prefix = 0;

        for &num in nums.iter() {
            prefix_sum += num;
            if prefix_sum > max_prefix {
                max_prefix = prefix_sum;
            }
            let current_sum = prefix_sum - max_prefix;
            if current_sum > 0 && current_sum < min_sum {
                min_sum = current_sum;
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}