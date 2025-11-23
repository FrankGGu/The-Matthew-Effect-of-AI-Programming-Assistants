impl Solution {
    pub fn minimize_max(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort();
        let n = nums.len();

        // This `check` function determines if it's possible to remove `k` elements
        // such that the maximum adjacent difference among the remaining `n-k` elements
        // is at most `max_diff`.
        // This is equivalent to checking if we can select a subsequence of at least `n-k` elements
        // where all adjacent differences are <= `max_diff`.
        // The greedy strategy for this is to keep an element if it satisfies the difference
        // constraint with the last kept element, otherwise skip it. This maximizes the number of kept elements.
        let check = |max_diff: i32| -> bool {
            let mut kept_count = 0;
            let mut last_kept_val = i32::MIN; // Initialize with a very small value to allow the first element to be kept.

            for i in 0..n {
                if nums[i] - last_kept_val <= max_diff {
                    kept_count += 1;
                    last_kept_val = nums[i];
                }
                // If nums[i] - last_kept_val > max_diff, we cannot keep nums[i] with the current last_kept_val.
                // We effectively "remove" nums[i] by not including it in the current subsequence.
                // The loop continues to the next element, attempting to extend the subsequence
                // using the same `last_kept_val` or a new one if `last_kept_val` itself is skipped later.
            }

            // We need to keep at least `n - k` elements.
            kept_count >= (n as i32 - k)
        };

        let mut low = 0;
        let mut high = nums[n-1] - nums[0];
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if check(mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }
}