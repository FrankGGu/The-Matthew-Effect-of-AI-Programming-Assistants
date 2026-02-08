impl Solution {
    pub fn optimal_division(nums: Vec<i32>) -> String {
        let n = nums.len();

        if n == 1 {
            return nums[0].to_string();
        }
        if n == 2 {
            return format!("{}/{}", nums[0], nums[1]);
        }

        let mut result = String::new();
        result.push_str(&nums[0].to_string());
        result.push_str("/(");
        result.push_str(&nums[1].to_string());

        for i in 2..n {
            result.push_str("/");
            result.push_str(&nums[i].to_string());
        }

        result.push_str(")");
        result
    }
}