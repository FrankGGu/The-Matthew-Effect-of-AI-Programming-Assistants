impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut max_so_far = nums[0];
        let mut min_so_far = nums[0];
        let mut result = nums[0];

        for i in 1..nums.len() {
            let curr = nums[i];
            let temp_max = std::cmp::max(curr, std::cmp::max(max_so_far * curr, min_so_far * curr));
            min_so_far = std::cmp::min(curr, std::cmp::min(max_so_far * curr, min_so_far * curr));

            max_so_far = temp_max;

            result = std::cmp::max(result, max_so_far);
        }

        result
    }
}