var sortThreeGroups = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    // Function to find the length of the Longest Non-Decreasing Subsequence (LNDS)
    const lengthOfLNDS = function(arr) {
        if (arr.length === 0) {
            return 0;
        }

        // tails[i] stores the smallest ending element of a non-decreasing subsequence of length i+1.
        const tails = [];

        for (const num of arr) {
            // Use binary search (upper_bound) to find the first element in tails that is strictly greater than num.
            // If such an element is found, it means we can potentially form a shorter non-decreasing subsequence
            // of the same length ending with a smaller value (num), which is better.
            // If no such element is found, num is greater than or equal to all elements in tails,
            // so it extends the longest non-decreasing subsequence found so far.
            let low = 0;
            let high = tails.length;
            let insertPos = tails.length; // Default to append if num is largest

            while (low < high) {
                let mid = Math.floor((low + high) / 2);
                if (tails[mid] > num) {
                    insertPos = mid;
                    high = mid;
                } else { // tails[mid] <= num, so num can extend this subsequence
                    low = mid + 1;
                }
            }

            if (insertPos === tails.length) {
                tails.push(num);
            } else {
                tails[insertPos] = num;
            }
        }

        return tails.length;
    };

    const lndsLength = lengthOfLNDS(nums);
    // The minimum number of changes is the total number of elements minus the length of the LNDS.
    // This is because the elements not in the LNDS must be changed to fit the non-decreasing group structure.
    return n - lndsLength;
};