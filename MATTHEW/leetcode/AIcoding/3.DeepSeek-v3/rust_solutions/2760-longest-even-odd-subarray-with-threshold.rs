impl Solution {
    pub fn longest_alternating_subarray(nums: Vec<i32>, threshold: i32) -> i32 {
        let mut max_len = 0;
        let n = nums.len();
        let mut i = 0;

        while i < n {
            if nums[i] % 2 != 0 || nums[i] > threshold {
                i += 1;
                continue;
            }
            let mut j = i + 1;
            while j < n {
                if nums[j] > threshold || nums[j] % 2 == nums[j - 1] % 2 {
                    break;
                }
                j += 1;
            }
            max_len = max_len.max(j - i);
            i = j;
        }

        max_len as i32
    }
}