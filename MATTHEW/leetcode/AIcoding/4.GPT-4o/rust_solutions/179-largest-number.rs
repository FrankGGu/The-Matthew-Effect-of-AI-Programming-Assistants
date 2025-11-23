impl Solution {
    pub fn largest_number(nums: Vec<i32>) -> String {
        let mut nums: Vec<String> = nums.into_iter().map(|n| n.to_string()).collect();
        nums.sort_by(|a, b| (b.clone() + a).cmp(&(a.clone() + b)));
        if nums[0] == "0" {
            return "0".to_string();
        }
        nums.join("")
    }
}