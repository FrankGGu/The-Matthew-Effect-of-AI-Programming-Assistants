impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let mut max_val = 0;
        for &num in &nums {
            max_val = max_val.max(num);
        }

        let mut max_len = 0;
        let mut current_len = 0;

        for &num in &nums {
            if num == max_val {
                current_len += 1;
                max_len = max_len.max(current_len);
            } else {
                current_len = 0;
            }
        }

        max_len
    }
}