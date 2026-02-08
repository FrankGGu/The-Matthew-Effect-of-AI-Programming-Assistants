impl Solution {
    pub fn max_subarray_sum_circular(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_sum = 0;
        let mut max_so_far = nums[0];
        let mut curr_max = 0;
        let mut min_so_far = nums[0];
        let mut curr_min = 0;

        for i in 0..n {
            total_sum += nums[i];

            curr_max = i32::max(nums[i], curr_max + nums[i]);
            max_so_far = i32::max(max_so_far, curr_max);

            curr_min = i32::min(nums[i], curr_min + nums[i]);
            min_so_far = i32::min(min_so_far, curr_min);
        }

        if max_so_far > 0 {
            i32::max(max_so_far, total_sum - min_so_far)
        } else {
            max_so_far
        }
    }
}