impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let n = nums.len();
        for i in 0..=n {
            let mut combination: Vec<i32> = Vec::new();
            Self::backtrack(&mut result, &mut combination, &nums, 0, i);
        }
        result
    }

    fn backtrack(result: &mut Vec<Vec<i32>>, combination: &mut Vec<i32>, nums: &Vec<i32>, start: usize, k: usize) {
        if combination.len() == k {
            result.push(combination.clone());
            return;
        }

        for i in start..nums.len() {
            combination.push(nums[i]);
            Self::backtrack(result, combination, nums, i + 1, k);
            combination.pop();
        }
    }
}