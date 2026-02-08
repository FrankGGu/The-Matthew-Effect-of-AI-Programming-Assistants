impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let max_num = *nums.iter().max().unwrap();
        let mut left = 0;
        let mut count = 0;
        let mut result = 0;

        for right in 0..nums.len() {
            if nums[right] == max_num {
                count += 1;
            }

            while count >= k {
                if nums[left] == max_num {
                    count -= 1;
                }
                left += 1;
                result += (nums.len() - right) as i64;
            }
        }

        result
    }
}