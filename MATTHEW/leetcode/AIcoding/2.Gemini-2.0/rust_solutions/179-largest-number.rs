impl Solution {
    pub fn largest_number(nums: Vec<i32>) -> String {
        let mut nums_str: Vec<String> = nums.iter().map(|&x| x.to_string()).collect();
        nums_str.sort_by(|a, b| {
            let ab = a.clone() + b;
            let ba = b.clone() + a;
            ba.cmp(&ab)
        });

        let result = nums_str.join("");
        if result.chars().all(|c| c == '0') {
            return "0".to_string();
        }
        result
    }
}