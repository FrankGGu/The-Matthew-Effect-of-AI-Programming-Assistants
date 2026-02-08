impl Solution {
    pub fn find_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if (num - i as i32).abs() == k {
                result.push(i as i32);
            }
        }
        result
    }
}