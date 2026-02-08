impl Solution {
    pub fn k_length_apart(nums: Vec<i32>, k: i32) -> bool {
        let mut last_one = -1;
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                if last_one != -1 && (i as i32 - last_one - 1) < k {
                    return false;
                }
                last_one = i as i32;
            }
        }
        true
    }
}