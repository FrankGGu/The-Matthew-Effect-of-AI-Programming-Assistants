impl Solution {
    pub fn shuffle(nums: Vec<i32>, n: i32) -> Vec<i32> {
        let mut shuffled_array = Vec::with_capacity(2 * n as usize);
        for i in 0..n as usize {
            shuffled_array.push(nums[i]);
            shuffled_array.push(nums[i + n as usize]);
        }
        shuffled_array
    }
}