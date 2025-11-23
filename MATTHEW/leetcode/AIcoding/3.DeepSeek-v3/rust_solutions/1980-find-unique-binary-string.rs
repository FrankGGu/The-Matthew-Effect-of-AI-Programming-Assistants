impl Solution {
    pub fn find_different_binary_string(nums: Vec<String>) -> String {
        let n = nums.len();
        for i in 0..=n {
            let s = format!("{:0width$b}", i, width = n);
            if !nums.contains(&s) {
                return s;
            }
        }
        String::new()
    }
}