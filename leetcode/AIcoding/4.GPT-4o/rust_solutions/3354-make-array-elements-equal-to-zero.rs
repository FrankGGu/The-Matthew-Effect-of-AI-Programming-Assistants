impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut max_num = 0;
        for &num in &nums {
            if num > max_num {
                max_num = num;
            }
        }
        max_num
    }
}