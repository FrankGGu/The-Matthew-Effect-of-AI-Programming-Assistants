impl Solution {
    pub fn optimal_division(nums: Vec<i32>) -> String {
        if nums.len() == 1 {
            return nums[0].to_string();
        }
        if nums.len() == 2 {
            return format!("{} / {}", nums[0], nums[1]);
        }
        let mut result = format!("{} / (", nums[0]);
        for &num in &nums[1..] {
            result.push_str(&format!("{}, ", num));
        }
        result.pop(); // remove last comma
        result.pop(); // remove last space
        result.push(')');
        result
    }
}