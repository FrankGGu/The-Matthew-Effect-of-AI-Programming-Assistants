impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();

        if n < 2 || m == 0 || m >= n {
            return 0;
        }

        let mut text_arr = Vec::with_capacity(n - 1);
        for i in 0..n - 1 {
            let val = if nums[i+1] > nums[i] {
                1
            } else if nums[i+1] == nums[i] {
                0
            } else {
                -1
            };
            text_arr.push(val);
        }

        let mut lps = vec![0; m];
        let mut length = 0;
        let mut i = 1;
        while i < m {
            if pattern[i] == pattern[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }

        let mut count = 0;
        let mut i = 0; 
        let mut j = 0; 

        let text_len = text_arr.len();

        while i < text_len {
            if pattern[j] == text_arr[i] {
                i += 1;
                j += 1;
            }

            if j == m {
                count += 1;
                j = lps[j - 1]; 
            } else if i < text_len && pattern[j] != text_arr[i] {
                if j != 0 {
                    j = lps[j - 1];
                } else {
                    i += 1;
                }
            }
        }
        count
    }
}