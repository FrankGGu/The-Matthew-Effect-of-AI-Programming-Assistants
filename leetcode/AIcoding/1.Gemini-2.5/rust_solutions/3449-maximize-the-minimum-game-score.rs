impl Solution {
    pub fn maximize_the_minimum_game_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        // Binary search for the maximum possible minimum sum among k subarrays.
        // The lower bound for the minimum sum is 0 (or the smallest element if all elements are positive).
        // The upper bound for the minimum sum is the total sum of all elements.
        let mut low = *nums.iter().min().unwrap_or(&0);
        let mut high: i32 = nums.iter().sum();
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_partition_with_min_sum(mid, &nums, k) {
                // If it's possible to partition into k (or more) subarrays
                // where each has a sum of at least `mid`, then `mid` is a possible answer.
                // We try to find an even larger minimum sum.
                ans = mid;
                low = mid + 1;
            } else {
                // If it's not possible to achieve `mid` as the minimum sum,
                // we need to try a smaller minimum sum.
                high = mid - 1;
            }
        }

        ans
    }

    // Helper function to check if it's possible to partition `nums` into `k` or more
    // contiguous subarrays, such that the sum of elements in each subarray is at least `target_min_sum`.
    fn can_partition_with_min_sum(target_min_sum: i32, nums: &[i32], k: i32) -> bool {
        let mut current_sum = 0;
        let mut parts_count = 0;

        for &num in nums {
            current_sum += num;
            // If any single element is greater than target_min_sum, it can form a part itself.
            // This condition ensures that if we have a large element, we don't necessarily need to
            // accumulate more elements to meet target_min_sum.
            // However, the greedy approach below handles this naturally:
            // if current_sum (which might just be `num`) is >= target_min_sum, we cut.
            // If num itself is less than target_min_sum, we must accumulate.

            // This greedy strategy tries to make each part as small as possible (but at least `target_min_sum`)
            // to maximize the number of parts.
            if current_sum >= target_min_sum {
                parts_count += 1;
                current_sum = 0; // Start a new part
            }
        }

        // If we were able to form at least `k` parts, then `target_min_sum` is achievable.
        // If we form more than `k` parts, we can always merge some to reduce the count to `k`,
        // and the minimum sum would still be at least `target_min_sum`.
        parts_count >= k
    }
}