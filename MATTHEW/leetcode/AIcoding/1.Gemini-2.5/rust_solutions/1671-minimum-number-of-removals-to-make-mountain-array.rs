impl Solution {
    pub fn minimum_mountain_removals(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut lis = vec![1; n]; // Longest Increasing Subsequence ending at index i
        let mut lds = vec![1; n]; // Longest Decreasing Subsequence starting at index i

        // Calculate LIS for each element
        for i in 0..n {
            for j in 0..i {
                if nums[j] < nums[i] {
                    lis[i] = lis[i].max(lis[j] + 1);
                }
            }
        }

        // Calculate LDS for each element
        for i in (0..n).rev() {
            for j in (i + 1)..n {
                if nums[j] < nums[i] {
                    lds[i] = lds[i].max(lds[j] + 1);
                }
            }
        }

        let mut max_mountain_len = 0;

        // Find the maximum length of a mountain array
        for i in 0..n {
            // A valid peak requires at least one element to its left and one to its right.
            // So, lis[i] must be > 1 and lds[i] must be > 1.
            // This ensures a strictly increasing part, a peak, and a strictly decreasing part.
            if lis[i] > 1 && lds[i] > 1 {
                max_mountain_len = max_mountain_len.max(lis[i] + lds[i] - 1);
            }
        }

        // The minimum number of removals is the total length minus the maximum mountain array length.
        (n - max_mountain_len) as i32
    }
}