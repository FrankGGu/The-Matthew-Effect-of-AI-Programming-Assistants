impl Solution {
    pub fn find_x_value(nums: Vec<i32>) -> i32 {
        let mut x = 0;
        for num in nums {
            x = x ^ num;
        }
        x
    }
}