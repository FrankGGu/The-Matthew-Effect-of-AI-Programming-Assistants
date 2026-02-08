impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(&nums, 0, &mut path, &mut res);
        res
    }

    fn backtrack(nums: &Vec<i32>, start: usize, path: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) {
        res.push(path.clone());
        for i in start..nums.len() {
            path.push(nums[i]);
            Self::backtrack(nums, i + 1, path, res);
            path.pop();
        }
    }
}