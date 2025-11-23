impl Solution {
    pub fn check_bitwise_or_has_trailing_zeros(nums: Vec<i32>) -> bool {
        let mut even_count = 0;
        for num in nums {
            if num % 2 == 0 {
                even_count += 1;
                if even_count >= 2 {
                    return true;
                }
            }
        }
        false
    }
}