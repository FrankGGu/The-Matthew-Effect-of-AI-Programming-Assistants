var kIncreasing = function(arr, k) {
    let totalOperations = 0;
    const n = arr.length;

    // Helper function to find the length of the Longest Non-decreasing Subsequence (LNDS)
    // This uses a patience sorting approach with binary search, O(L log L) time complexity
    // where L is the length of the subsequence.
    const lengthOfLNDS = (subsequence) => {
        if (subsequence.length === 0) {
            return 0;
        }

        // 'tails' stores the smallest end element of all non-decreasing subsequences
        // of a given length. tails[i] is the smallest tail of all LNDS of length i+1.
        const tails = [];

        for (const num of subsequence) {
            // Binary search to find the insertion point for 'num'.
            // We are looking for the first element in 'tails' that is strictly greater than 'num'.
            // If such an element exists, 'num' can replace it to form a non-decreasing subsequence
            // of the same length but with a smaller ending element, which is always better or equal.
            // If no such element exists (i.e., 'num' is greater than or equal to all elements in 'tails'),
            // then 'num' extends the longest non-decreasing subsequence found so far.
            let low = 0;
            let high = tails.length;

            while (low < high) {
                const mid = Math.floor((low + high) / 2);
                if (tails[mid] <= num) {
                    // If tails[mid] is less than or equal to num, num can potentially extend
                    // a subsequence ending at tails[mid] or earlier.
                    // We need to look for a strictly greater element to replace, so search in the right half.
                    low = mid + 1;
                } else {
                    // If tails[mid] is strictly greater than num, it's a candidate for replacement.
                    // We try to find an even smaller element to replace in the left half.
                    high = mid;
                }
            }

            // At this point, 'low' is the index where 'num' should be inserted/replaced.
            if (low === tails.length) {
                // If 'low' is equal to tails.length, it means 'num' is greater than or equal
                // to all elements in 'tails', so it extends the longest subsequence.
                tails.push(num);
            } else {
                // Otherwise, replace the element at 'low' with 'num'.
                // This creates a non-decreasing subsequence of length 'low + 1' ending with a smaller 'num'.
                tails[low] = num;
            }
        }

        return tails.length;
    };

    // The problem can be broken down into k independent subproblems.
    // For each starting index j from 0 to k-1, the subsequence
    // arr[j], arr[j+k], arr[j+2k], ... must be non-decreasing.
    for (let j = 0; j < k; j++) {
        const currentSubsequence = [];
        for (let i = j; i < n; i += k) {
            currentSubsequence.push(arr[i]);
        }

        // The minimum number of operations to make a sequence non-decreasing
        // is its length minus the length of its Longest Non-decreasing Subsequence (LNDS).
        const lndsLength = lengthOfLNDS(currentSubsequence);
        totalOperations += (currentSubsequence.length - lndsLength);
    }

    return totalOperations;
};