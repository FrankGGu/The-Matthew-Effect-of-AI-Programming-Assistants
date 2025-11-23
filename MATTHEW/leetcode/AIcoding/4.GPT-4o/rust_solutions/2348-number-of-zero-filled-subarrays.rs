impl Solution {
    pub fn zero_filled_subarray(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut result = 0;

        for &num in nums.iter() {
            if num == 0 {
                count += 1;
                result += count;
            } else {
                count = 0;
            }
        }

        result
    }
}