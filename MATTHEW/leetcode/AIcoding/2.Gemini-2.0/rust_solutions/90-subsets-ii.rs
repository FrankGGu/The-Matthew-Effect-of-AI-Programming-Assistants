impl Solution {
    pub fn subsets_with_dup(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut nums = nums;
        nums.sort();
        let mut result: Vec<Vec<i32>> = vec![vec![]];
        let mut start_index = 0;
        for i in 0..nums.len() {
            let current_size = result.len();
            if i > 0 && nums[i] == nums[i - 1] {
                start_index = current_size - start_index;
            } else {
                start_index = 0;
            }
            for j in start_index..current_size {
                let mut subset = result[j].clone();
                subset.push(nums[i]);
                result.push(subset);
            }
        }
        result
    }
}