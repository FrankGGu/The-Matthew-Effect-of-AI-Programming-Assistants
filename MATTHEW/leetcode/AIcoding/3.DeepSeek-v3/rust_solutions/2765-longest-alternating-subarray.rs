impl Solution {
    pub fn alternating_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_len = -1;

        for i in 0..n {
            for j in i + 1..n {
                let expected = if (j - i) % 2 == 1 {
                    nums[i] + 1
                } else {
                    nums[i]
                };
                if nums[j] == expected {
                    max_len = max_len.max((j - i + 1) as i32);
                } else {
                    break;
                }
            }
        }

        max_len
    }
}