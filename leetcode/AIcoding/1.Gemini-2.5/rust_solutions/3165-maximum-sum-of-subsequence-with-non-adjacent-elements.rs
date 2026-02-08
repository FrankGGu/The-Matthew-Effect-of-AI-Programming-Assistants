impl Solution {
    pub fn max_sum_subsequence_with_non_adjacent_elements(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut include_prev = 0;
        let mut exclude_prev = 0;

        for &num in nums.iter() {
            let new_include_curr = exclude_prev + num;
            let new_exclude_curr = std::cmp::max(include_prev, exclude_prev);

            include_prev = new_include_curr;
            exclude_prev = new_exclude_curr;
        }

        std::cmp::max(include_prev, exclude_prev)
    }
}