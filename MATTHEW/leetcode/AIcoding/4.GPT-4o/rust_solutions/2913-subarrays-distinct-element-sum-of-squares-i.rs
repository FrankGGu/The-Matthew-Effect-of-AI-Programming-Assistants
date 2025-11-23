impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let mut distinct_elements = std::collections::HashSet::new();
        let n = nums.len();
        let mut result = 0;

        for i in 0..n {
            distinct_elements.clear();
            for j in i..n {
                distinct_elements.insert(nums[j]);
                result += distinct_elements.len() as i32 * distinct_elements.len() as i32;
            }
        }

        result
    }
}