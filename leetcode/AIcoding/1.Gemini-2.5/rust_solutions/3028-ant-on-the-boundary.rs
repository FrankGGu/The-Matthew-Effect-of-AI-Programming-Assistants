impl Solution {
    pub fn return_to_boundary(nums: Vec<i32>) -> i32 {
        let mut current_position = 0;
        let mut count = 0;

        for step in nums {
            current_position += step;
            if current_position == 0 {
                count += 1;
            }
        }

        count
    }
}