struct Solution;

impl Solution {
    pub fn min_number(nums: Vec<i32>) -> String {
        let mut strs: Vec<String> = nums.into_iter().map(|n| n.to_string()).collect();

        strs.sort_by(|a, b| {
            let s1 = format!("{}{}", a, b);
            let s2 = format!("{}{}", b, a);
            s1.cmp(&s2)
        });

        let result = strs.join("");

        if result.starts_with('0') && result.len() > 1 {
            "0".to_string()
        } else {
            result
        }
    }
}