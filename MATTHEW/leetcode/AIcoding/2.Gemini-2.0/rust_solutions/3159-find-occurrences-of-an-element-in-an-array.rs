impl Solution {
    pub fn find_occurrences(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        for (index, &num) in nums.iter().enumerate() {
            if num == target {
                result.push(index as i32);
            }
        }
        result
    }
}