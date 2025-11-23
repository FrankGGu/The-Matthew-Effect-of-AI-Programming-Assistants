struct Solution;

impl Solution {
    pub fn prefixes_div_by5(mut nums: Vec<i32>) -> Vec<bool> {
        let mut result = Vec::new();
        let mut mod_val = 0;
        for num in nums.iter() {
            mod_val = (mod_val * 2 + num) % 5;
            result.push(mod_val == 0);
        }
        result
    }
}