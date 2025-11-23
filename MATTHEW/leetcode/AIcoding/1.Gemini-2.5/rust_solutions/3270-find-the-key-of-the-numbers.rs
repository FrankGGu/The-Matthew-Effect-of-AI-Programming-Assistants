impl Solution {
    pub fn find_key(nums: Vec<i32>, key: i32) -> i32 {
        for i in 0..nums.len() {
            if nums[i] == key {
                return i as i32;
            }
        }
        -1
    }
}