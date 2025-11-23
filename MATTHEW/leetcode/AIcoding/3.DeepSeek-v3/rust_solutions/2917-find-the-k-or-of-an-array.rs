impl Solution {
    pub fn find_k_or(nums: Vec<i32>, k: i32) -> i32 {
        let mut result = 0;
        for i in 0..32 {
            let mut count = 0;
            for &num in &nums {
                if num & (1 << i) != 0 {
                    count += 1;
                }
            }
            if count >= k {
                result |= 1 << i;
            }
        }
        result
    }
}