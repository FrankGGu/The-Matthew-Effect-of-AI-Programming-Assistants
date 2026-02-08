impl Solution {
    pub fn count_increasing_quadruplets(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut ans: i64 = 0;

        // less[idx][val] stores the count of numbers nums[p] where p < idx and nums[p] < val
        // The values in nums are 1-indexed, from 1 to n.
        // So, val can range from 0 to n.
        let mut less = vec![vec![0; n + 1]; n + 1];

        // Precompute less table
        // less[0] is all zeros (no elements before index 0)
        for i in 0..n {
            for v in 0..=n {
                less[i + 1][v] = less[i][v];
            }
            // Add contribution from nums[i] to counts for values greater than nums[i]
            // nums[i] is 1-indexed value, so iterate from nums[i] + 1
            for v_idx in (nums[i] as usize + 1)..=n {
                less[i + 1][v_idx] += 1;
            }
        }

        // greater[idx][val] stores the count of numbers nums[p] where p >= idx and nums[p] > val
        let mut greater = vec![vec![0; n + 1]; n + 1];

        // Precompute greater table
        // greater[n] is all zeros (no elements at or after index n)
        for i in (0..n).rev() { // i goes from n-1 down to 0
            // greater[i] is based on greater[i+1] (elements at or after i+1)
            for v in 0..=n {
                greater[i][v] = greater[i + 1][v];
            }
            // Add contribution from nums[i] to counts for values less than nums[i]
            // nums[i] is 1-indexed value, so iterate from 0 to nums[i] - 1
            for v_idx in 0..(nums[i] as usize) {
                greater[i][v_idx] += 1;
            }
        }

        // Iterate j and k
        // We need 0 <= i < j < k < l < n
        // And nums[i] < nums[k] < nums[j] < nums[l]
        // j must be at least 1 (for i=0), at most n-3 (for k=n-2, l=n-1)
        // k must be at least j+1, at most n-2 (for l=n-1)
        for j in 1..n - 2 {
            for k in (j + 1)..n - 1 {
                // Condition: nums[k] < nums[j]
                if nums[k] < nums[j] {
                    // count_i: number of i < j such that nums[i] < nums[k]
                    // This is less[j][nums[k]]
                    let count_i = less[j][nums[k] as usize] as i64;

                    // count_l: number of l > k such that nums[l] > nums[j]
                    // Since greater[idx][val] counts p >= idx, for l > k, we need p >= k+1.
                    // This is greater[k+1][nums[j]]
                    let count_l = greater[k + 1][nums[j] as usize] as i64;

                    ans += count_i * count_l;
                }
            }
        }

        ans
    }
}