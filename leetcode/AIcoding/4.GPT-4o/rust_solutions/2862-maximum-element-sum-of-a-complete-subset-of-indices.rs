impl Solution {
    pub fn max_element_sum(nums: Vec<i32>, indices: Vec<Vec<i32>>) -> i32 {
        let mut total_sum = 0;
        for index_set in indices {
            let mut subset_sum = 0;
            for &index in &index_set {
                subset_sum += nums[index as usize];
            }
            total_sum = total_sum.max(subset_sum);
        }
        total_sum
    }
}