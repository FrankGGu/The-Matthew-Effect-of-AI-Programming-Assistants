impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();
        let mut diffs = Vec::with_capacity(n - 1);
        for i in 0..n - 1 {
            diffs.push((nums[i + 1] - nums[i]).signum());
        }

        let mut kmp_table = vec![0; m];
        let mut len = 0;
        let mut i = 1;
        while i < m {
            if pattern[i] == pattern[len] {
                len += 1;
                kmp_table[i] = len;
                i += 1;
            } else {
                if len != 0 {
                    len = kmp_table[len - 1];
                } else {
                    kmp_table[i] = 0;
                    i += 1;
                }
            }
        }

        let mut count = 0;
        let mut i = 0;
        let mut j = 0;
        while i < n - 1 {
            if pattern[j] == diffs[i] {
                i += 1;
                j += 1;
            }
            if j == m {
                count += 1;
                j = kmp_table[m - 1];
            } else if i < n - 1 && pattern[j] != diffs[i] {
                if j != 0 {
                    j = kmp_table[j - 1];
                } else {
                    i += 1;
                }
            }
        }

        count
    }
}