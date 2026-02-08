var minimumPairRemoval = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    // tails[i] stores the smallest ending element of a non-decreasing subsequence of length i+1.
    // This array helps in finding the Longest Non-Decreasing Subsequence (LNDS) in O(N log N) time.
    const tails = [];

    for (const num of nums) {
        // Perform binary search to find the correct position for 'num' in the 'tails' array.
        // We are looking for the first element in 'tails' that is strictly greater than 'num'.
        // If 'num' is greater than or equal to all elements in 'tails', it extends the LNDS.
        let low = 0;
        let high = tails.length;

        while (low < high) {
            const mid = Math.floor((low + high) / 2);
            if (tails[mid] <= num) {
                // If tails[mid] is less than or equal to 'num',
                // 'num' can potentially extend this subsequence or a longer one.
                // We need to look in the right half for a strictly greater element.
                low = mid + 1;
            } else {
                // If tails[mid] is strictly greater than 'num',
                // this could be the element we want to replace, or an element to its left.
                high = mid;
            }
        }

        // After the loop, 'low' is the index where 'num' should be placed
        // to maintain the non-decreasing property of 'tails'.
        if (low === tails.length) {
            // If 'low' is equal to 'tails.length', it means 'num' is greater than or equal
            // to all elements in 'tails'. Thus, 'num' extends the longest non-decreasing subsequence found so far.
            tails.push(num);
        } else {
            // Otherwise, 'num' replaces 'tails[low]'. This means we found a non-decreasing
            // subsequence of length 'low + 1' that ends with a smaller value ('num').
            // This replacement is beneficial because it allows for potentially longer
            // non-decreasing subsequences to be formed later.
            tails[low] = num;
        }
    }

    // The length of the 'tails' array is the length of the Longest Non-Decreasing Subsequence.
    const lndsLength = tails.length;

    // The minimum number of elements to remove to make the array sorted
    // (i.e., to obtain the LNDS) is the total number of elements minus the LNDS length.
    let elementsToRemove = n - lndsLength;

    // The problem title "Minimum Pair Removal" often implies that the total number of removed elements
    // must be an even number (as elements are removed in pairs).
    // If 'elementsToRemove' is an odd number, we must remove one additional element
    // to satisfy the "pair removal" constraint, making the total count of removals even.
    if (elementsToRemove % 2 !== 0) {
        return elementsToRemove + 1;
    } else {
        return elementsToRemove;
    }
};