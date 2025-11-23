impl Solution {
    pub fn is_good(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut count = vec![0; n + 1];

        for &num in &nums {
            if num <= n as i32 {
                count[num as usize] += 1;
            }
        }

        for i in 1..=n {
            if count[i] != 1 && count[i] != 0 {
                return false;
            }
        }

        true
    }
}