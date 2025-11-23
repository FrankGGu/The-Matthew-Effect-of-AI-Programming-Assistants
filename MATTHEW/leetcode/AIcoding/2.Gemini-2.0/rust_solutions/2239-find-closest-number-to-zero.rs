impl Solution {
    pub fn find_closest_number(nums: Vec<i32>) -> i32 {
        let mut closest = nums[0];
        for &num in &nums {
            if num.abs() < closest.abs() {
                closest = num;
            } else if num.abs() == closest.abs() && num > closest {
                closest = num;
            }
        }
        closest
    }
}