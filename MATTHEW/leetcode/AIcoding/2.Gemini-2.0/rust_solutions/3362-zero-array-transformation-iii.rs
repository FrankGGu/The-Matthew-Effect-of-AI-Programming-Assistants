impl Solution {
    pub fn zero_array(nums: Vec<i32>) -> bool {
        let mut sum: i64 = 0;
        let mut max_val: i32 = 0;
        for &num in &nums {
            sum += num as i64;
            max_val = max_val.max(num);
        }

        if sum % 2 != 0 {
            return false;
        }

        (max_val as i64) * 2 <= sum
    }
}