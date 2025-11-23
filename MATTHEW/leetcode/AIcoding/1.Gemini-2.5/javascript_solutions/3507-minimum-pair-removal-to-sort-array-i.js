var minPairRemoval = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    // `tails` stores the smallest tail of all increasing subsequences of length `i+1`.
    // For example, if tails[i] = x, it means there is an increasing subsequence of length i+1 ending with x,
    // and x is the smallest such ending found so far for that length.
    // This array will always be sorted in strictly increasing order.
    const tails = [];

    for (const num of nums) {
        // Binary search to find the position to insert `num`.
        // We are looking for the first element in `tails` that is greater than or equal to `num`.
        // This is equivalent to `lower_bound` in C++ STL.
        let low = 0;
        let high = tails.length; // Use tails.length as exclusive upper bound for binary search

        while (low < high) {
            const mid = Math.floor((low + high) / 2);
            if (tails[mid] < num) {
                // `num` cannot replace `tails[mid]` to form a strictly increasing subsequence
                // of the same length ending with a smaller value. We need to look to the right.
                low = mid + 1;
            } else {
                // `tails[mid]` is >= `num`. This `mid` is a potential position.
                // We try to find an even smaller index (further left) that satisfies this condition.
                high = mid;
            }
        }

        // After the loop, `low` is the index where `num` should be placed
        // to maintain the sorted order of `tails` and ensure `tails[low]` is the smallest tail
        // for a strictly increasing subsequence of length `low+1`.
        if (low === tails.length) {
            // `num` is greater than all elements in `tails`, so it extends the longest subsequence.
            tails.push(num);
        } else {
            // `num` can replace `tails[low]`. This means we found a smaller ending for
            // an increasing subsequence of length `low+1`, which is more favorable
            // for extending future subsequences.
            tails[low] = num;
        }
    }

    // The length of `tails` is the length of the Longest Increasing Subsequence (LIS).
    // The minimum number of removals to make the array sorted (strictly increasing)
    // is the total length of the array minus the length of the LIS.
    return nums.length - tails.length;
};