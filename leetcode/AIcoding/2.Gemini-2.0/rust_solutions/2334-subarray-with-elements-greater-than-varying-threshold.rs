impl Solution {
    pub fn valid_subarray(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        for len in (1..=n).rev() {
            for i in 0..=n - len {
                let mut valid = true;
                for j in i..i + len {
                    if nums[j] as i64 <= (threshold as i64) / (len as i64) {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    return len as i32;
                }
            }
        }
        0
    }
}