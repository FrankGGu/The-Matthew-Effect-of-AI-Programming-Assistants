impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut nums = nums;
        Self::permute_recursive(&mut nums, 0, &mut result);
        result
    }

    fn permute_recursive(nums: &mut Vec<i32>, l: usize, result: &mut Vec<Vec<i32>>) {
        if l == nums.len() {
            result.push(nums.clone());
            return;
        }

        for i in l..nums.len() {
            nums.swap(l, i);
            Self::permute_recursive(nums, l + 1, result);
            nums.swap(l, i);
        }
    }
}