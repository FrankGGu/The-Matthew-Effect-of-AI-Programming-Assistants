impl Solution {
    pub fn k_length_apart(nums: Vec<i32>, k: i32) -> bool {
        let mut prev = -k - 1;
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                if (i as i32 - prev - 1) < k {
                    return false;
                }
                prev = i as i32;
            }
        }
        true
    }
}