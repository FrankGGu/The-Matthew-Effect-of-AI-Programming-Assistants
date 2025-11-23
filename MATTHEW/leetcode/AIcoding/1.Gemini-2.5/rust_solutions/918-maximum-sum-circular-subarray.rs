impl Solution {
    pub fn max_subarray_sum_circular(nums: Vec<i32>) -> i32 {
        let mut max_so_far = i32::MIN;
        let mut min_so_far = i32::MAX;
        let mut current_max = 0;
        let mut current_min = 0;
        let mut total_sum = 0;

        for &n in nums.iter() {
            total_sum += n;

            current_max = n.max(current_max + n);
            max_so_far = max_so_far.max(current_max);

            current_min = n.min(current_min + n);
            min_so_far = min_so_far.min(current_min);
        }

        if max_so_far < 0 {
            max_so_far
        } else {
            max_so_far.max(total_sum - min_so_far)
        }
    }
}