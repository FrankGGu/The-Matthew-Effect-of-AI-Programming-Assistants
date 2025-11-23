impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = vec![];
        let n = nums.len();
        let total_subsets = 1 << n;

        for i in 0..total_subsets {
            let mut subset = vec![];
            for j in 0..n {
                if i & (1 << j) != 0 {
                    subset.push(nums[j]);
                }
            }
            result.push(subset);
        }

        result
    }
}