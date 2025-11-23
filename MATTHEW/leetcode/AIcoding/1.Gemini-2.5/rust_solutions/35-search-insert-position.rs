impl Solution {
    pub fn search_insert(nums: Vec<i32>, target: i32) -> i32 {
        match nums.binary_search(&target) {
            Ok(idx) => idx as i32,
            Err(idx) => idx as i32,
        }
    }
}