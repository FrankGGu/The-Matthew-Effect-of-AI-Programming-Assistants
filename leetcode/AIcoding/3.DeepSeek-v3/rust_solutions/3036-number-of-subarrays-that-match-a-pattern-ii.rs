impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();
        if n <= m {
            return 0;
        }

        let mut lps = vec![0; m];
        let mut len = 0;
        let mut i = 1;
        while i < m {
            if pattern[i] == pattern[len] {
                len += 1;
                lps[i] = len;
                i += 1;
            } else {
                if len != 0 {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }

        let mut res = 0;
        let mut i = 0;
        let mut j = 0;
        while i < n - 1 && j < m {
            let curr = if nums[i + 1] > nums[i] {
                1
            } else if nums[i + 1] == nums[i] {
                0
            } else {
                -1
            };
            if curr == pattern[j] {
                i += 1;
                j += 1;
                if j == m {
                    res += 1;
                    j = lps[j - 1];
                }
            } else {
                if j != 0 {
                    j = lps[j - 1];
                } else {
                    i += 1;
                }
            }
        }
        res
    }
}