impl Solution {
    pub fn K_length_apart(nums: Vec<i32>, k: i32) -> bool {
        let mut last_position = -1;
        let k = k as i32;

        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                if last_position != -1 && i as i32 - last_position - 1 < k {
                    return false;
                }
                last_position = i as i32;
            }
        }
        true
    }
}