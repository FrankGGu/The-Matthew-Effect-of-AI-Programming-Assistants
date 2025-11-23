use std::collections::HashSet;

impl Solution {
    pub fn find_unique_binary_string(nums: Vec<String>) -> String {
        let n = nums.len();
        let mut seen_numbers: HashSet<u16> = HashSet::new();

        for num_str in nums.iter() {
            if let Ok(num_val) = u16::from_str_radix(num_str, 2) {
                seen_numbers.insert(num_val);
            }
        }

        for i in 0..(1 << n) {
            if !seen_numbers.contains(&(i as u16)) {
                return format!("{:0width$b}", i, width = n);
            }
        }

        unreachable!("A unique binary string must exist given the problem constraints.");
    }
}