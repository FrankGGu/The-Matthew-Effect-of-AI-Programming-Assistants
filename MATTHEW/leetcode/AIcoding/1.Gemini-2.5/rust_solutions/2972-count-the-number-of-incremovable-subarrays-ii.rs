impl Solution {
    pub fn incremovable_subarray_count(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        // Calculate left_len: length of the longest strictly increasing prefix
        // nums[0..left_len-1] is strictly increasing.
        // left_len will be 1 if n=1 or nums[0] >= nums[1].
        let mut left_len = 1;
        while left_len < n && nums[left_len] > nums[left_len - 1] {
            left_len += 1;
        }

        // Calculate right_len: length of the longest strictly increasing suffix
        // nums[n-right_len..n-1] is strictly increasing.
        // right_len will be 1 if n=1 or nums[n-2] >= nums[n-1].
        let mut right_len = 1;
        while right_len < n && nums[n - right_len - 1] < nums[n - right_len] {
            right_len += 1;
        }

        let mut ans = 0;

        // 'i' represents the index of the element *before* the removed subarray.
        // The prefix is nums[0..i-1].
        // 'i' ranges from 0 to left_len (inclusive).
        // If i=0, the prefix is empty.
        // If i=left_len, the prefix is nums[0..left_len-1], which is strictly increasing.
        for i in 0..=left_len {
            // val_before_removed is nums[i-1] if i > 0, otherwise a sentinel value (-1)
            // that is smaller than any possible nums[k].
            let val_before_removed = if i == 0 { -1 } else { nums[i - 1] };

            // 'k' represents the index of the element *after* the removed subarray.
            // The suffix is nums[k..n-1].
            // The removed subarray is nums[i..k-1].
            // It must be non-empty, so k-1 >= i, which means k > i.
            // So k must be at least i + 1.
            let mut start_k = i + 1;

            // The suffix nums[k..n-1] must be strictly increasing.
            // This is true if k >= n - right_len.
            start_k = start_k.max(n - right_len);

            // If start_k is greater than n, it means there are no valid 'k's for this 'i'.
            // This happens if (i+1) > n or (n-right_len) > n.
            if start_k > n {
                continue;
            }

            // We need to count 'k' in the range [start_k, n] such that:
            // 1. (Implicitly handled by loop bounds) nums[0..i-1] is increasing.
            // 2. (Implicitly handled by start_k) nums[k..n-1] is increasing.
            // 3. If i > 0 (prefix exists) and k < n (suffix exists), then nums[i-1] < nums[k].

            if i == 0 {
                // If the prefix is empty, condition 3 (nums[i-1] < nums[k]) is skipped.
                // All 'k' from start_k to n (inclusive) are valid.
                // The count is (n - start_k + 1).
                ans += (n - start_k + 1) as i64;
            } else {
                // If the prefix is not empty (i > 0), we need to satisfy nums[i-1] < nums[k]
                // for k in [start_k, n-1].
                // The case k=n (empty suffix) is always valid if the prefix is valid.

                // The slice nums[start_k..n] is guaranteed to be strictly increasing
                // because start_k >= n - right_len.
                // We can use binary search (partition_point) on this slice to find the first element > val_before_removed.
                let search_slice = &nums[start_k..n];

                // partition_point returns the index of the first element for which the predicate is true.
                // We want elements > val_before_removed, so predicate is x <= val_before_removed.
                let idx_in_slice = search_slice.partition_point(|&x| x <= val_before_removed);

                // 'first_valid_k' is the actual index in 'nums' of the first element
                // in the suffix that is strictly greater than 'val_before_removed'.
                let first_valid_k = start_k + idx_in_slice;

                // All 'k' from 'first_valid_k' to 'n-1' are valid.
                // The count for these 'k's is (n - 1) - first_valid_k + 1 = n - first_valid_k.
                // Additionally, 'k=n' (empty suffix) is also a valid choice.
                // So, total count for this 'i' is (n - first_valid_k + 1).
                ans += (n - first_valid_k + 1) as i64;
            }
        }

        ans
    }
}