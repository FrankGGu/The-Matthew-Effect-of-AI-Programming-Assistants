impl Solution {
    pub fn find_the_xor(nums: Vec<i32>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        let mut result = 0;

        for &num in &nums {
            if !seen.insert(num) {
                result ^= num;
            }
        }

        result
    }
}