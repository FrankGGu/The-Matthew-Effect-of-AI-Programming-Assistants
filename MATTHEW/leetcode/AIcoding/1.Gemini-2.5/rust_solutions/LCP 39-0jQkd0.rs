impl Solution {
    pub fn single_number(nums: Vec<i32>) -> i32 {
        let mut unique_number = 0;
        for num in nums {
            unique_number ^= num;
        }
        unique_number
    }
}