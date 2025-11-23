impl Solution {
    pub fn subsets_with_dup(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res = vec![];
        let mut subset = vec![];
        let mut nums = nums;
        nums.sort();
        Self::backtrack(&nums, 0, &mut subset, &mut res);
        res
    }

    fn backtrack(nums: &[i32], start: usize, subset: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
        res.push(subset.clone());
        for i in start..nums.len() {
            if i > start && nums[i] == nums[i - 1] {
                continue;
            }
            subset.push(nums[i]);
            Self::backtrack(nums, i + 1, subset, res);
            subset.pop();
        }
    }
}