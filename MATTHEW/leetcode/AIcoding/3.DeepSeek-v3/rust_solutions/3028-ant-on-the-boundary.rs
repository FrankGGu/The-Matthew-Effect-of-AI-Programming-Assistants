impl Solution {
    pub fn return_to_boundary_count(nums: Vec<i32>) -> i32 {
        let mut position = 0;
        let mut count = 0;
        for num in nums {
            position += num;
            if position == 0 {
                count += 1;
            }
        }
        count
    }
}