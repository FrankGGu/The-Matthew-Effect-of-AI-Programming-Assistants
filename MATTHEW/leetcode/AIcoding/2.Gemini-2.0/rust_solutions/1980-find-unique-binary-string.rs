impl Solution {
    pub fn find_different_binary_string(nums: Vec<String>) -> String {
        let n = nums.len();
        let mut result = String::new();
        for i in 0..n {
            let num = nums[i].chars().nth(i).unwrap();
            if num == '0' {
                result.push('1');
            } else {
                result.push('0');
            }
        }
        result
    }
}