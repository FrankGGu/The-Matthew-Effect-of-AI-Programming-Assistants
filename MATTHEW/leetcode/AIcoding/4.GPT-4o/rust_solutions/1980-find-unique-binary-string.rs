impl Solution {
    pub fn find_unique_binary_string(mut nums: Vec<String>) -> String {
        let n = nums.len();
        let mut seen = vec![false; n];
        for num in nums {
            let mut index = 0;
            for c in num.chars() {
                index = (index << 1) | (c.to_digit(2).unwrap() as usize);
            }
            seen[index] = true;
        }
        for i in 0..(1 << n) {
            if !seen[i] {
                return format!("{:0width$b}", i, width = n);
            }
        }
        String::new()
    }
}