impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap();
        let mut max_len = 0;
        let mut current_len = 0;

        for &num in nums.iter() {
            if num == max_num {
                current_len += 1;
                max_len = max_len.max(current_len);
            } else {
                current_len = 0;
            }
        }

        max_len
    }
}