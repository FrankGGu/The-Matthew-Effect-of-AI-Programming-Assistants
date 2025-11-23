impl Solution {
    pub fn min_operations_to_make_median_k(mut nums: Vec<i32>, k: i32) -> i64 {
        nums.sort_unstable();
        let n = nums.len();
        let m = n / 2;

        let mut operations: i64 = 0;

        // Operations for the median element itself
        operations += (nums[m] - k).abs() as i64;

        // Operations for elements to the left of the median
        // These elements should be less than or equal to k
        for i in 0..m {
            if nums[i] > k {
                operations += (nums[i] - k) as i64;
            }
        }

        // Operations for elements to the right of the median
        // These elements should be greater than or equal to k
        for i in (m + 1)..n {
            if nums[i] < k {
                operations += (k - nums[i]) as i64;
            }
        }

        operations
    }
}