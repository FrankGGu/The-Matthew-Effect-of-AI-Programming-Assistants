impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0; 
        }

        let mut max_so_far = nums[0];
        let mut min_so_far = nums[0];
        let mut result = nums[0];

        for i in 1..nums.len() {
            let n = nums[i];

            let temp_max = max_so_far;

            max_so_far = std::cmp::max(n, std::cmp::max(max_so_far * n, min_so_far * n));
            min_so_far = std::cmp::min(n, std::cmp::min(temp_max * n, min_so_far * n));

            result = std::cmp::max(result, max_so_far);
        }

        result
    }
}