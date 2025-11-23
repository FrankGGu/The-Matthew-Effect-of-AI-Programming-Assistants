impl Solution {
    pub fn shuffle(nums: Vec<i32>, n: usize) -> Vec<i32> {
        let mut result = Vec::with_capacity(2 * n);
        for i in 0..n {
            result.push(nums[i]);
            result.push(nums[i + n]);
        }
        result
    }
}