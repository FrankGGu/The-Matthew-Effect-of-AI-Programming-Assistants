impl Solution {
    pub fn max_subarray_sum_circular(nums: Vec<i32>) -> i32 {
        let (mut total, mut max_sum, mut min_sum) = (0, nums[0], nums[0]);
        let (mut current_max, mut current_min) = (0, 0);

        for &num in &nums {
            current_max = num.max(current_max + num);
            max_sum = max_sum.max(current_max);
            current_min = num.min(current_min + num);
            min_sum = min_sum.min(current_min);
            total += num;
        }

        if max_sum > 0 {
            max_sum.max(total - min_sum)
        } else {
            max_sum
        }
    }
}