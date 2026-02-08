impl Solution {
    pub fn return_to_boundary_count(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut current_position = 0;
        for num in nums {
            current_position += num;
            if current_position == 0 {
                count += 1;
            }
        }
        count
    }
}