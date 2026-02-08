impl Solution {
    pub fn find_closest_number(nums: Vec<i32>) -> i32 {
        let mut closest = i32::MAX;
        for &num in &nums {
            if num.abs() < closest.abs() || (num.abs() == closest.abs() && num > closest) {
                closest = num;
            }
        }
        closest
    }
}