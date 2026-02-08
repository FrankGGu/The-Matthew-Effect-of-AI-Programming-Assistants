impl Solution {
    pub fn max_absolute_sum(nums: Vec<i32>) -> i32 {
        let mut max_so_far = 0;
        let mut min_so_far = 0;
        let mut current_max = 0;
        let mut current_min = 0;

        for &num in &nums {
            current_max = std::cmp::max(num, current_max + num);
            max_so_far = std::cmp::max(max_so_far, current_max);

            current_min = std::cmp::min(num, current_min + num);
            min_so_far = std::cmp::min(min_so_far, current_min);
        }

        std::cmp::max(max_so_far, -min_so_far)
    }
}