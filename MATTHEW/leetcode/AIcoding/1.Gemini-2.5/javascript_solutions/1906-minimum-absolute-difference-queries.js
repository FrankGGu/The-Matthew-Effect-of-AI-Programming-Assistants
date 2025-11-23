var minAbsoluteDifferenceQueries = function(nums, queries) {
    const n = nums.length;
    const maxVal = 100; // Numbers in nums are between 1 and 100

    // prefixCounts[i][j] stores the count of number j in nums[0...i-1]
    // The array has n+1 rows to handle prefix counts up to index n-1 (i.e., nums[0...n-1])
    // The columns go up to maxVal (100), so maxVal+1 columns for indices 0-100.
    const prefixCounts = Array(n + 1).fill(0).map(() => Array(maxVal + 1).fill(0));

    // Build the prefix count array
    for (let i = 0; i < n; i++) {
        // Copy the counts from the previous prefix
        for (let j = 1; j <= maxVal; j++) {
            prefixCounts[i + 1][j] = prefixCounts[i][j];
        }
        // Increment the count for the current number nums[i]
        prefixCounts[i + 1][nums[i]]++;
    }

    const results = [];

    // Process each query
    for (const query of queries) {
        const [l, r] = query; // Query range [l, r] inclusive

        let minDiff = Infinity;
        let lastSeenValue = -1; // To keep track of the previously found distinct number

        // Iterate through all possible values from 1 to maxVal
        for (let val = 1; val <= maxVal; val++) {
            // Check if 'val' is present in the subarray nums[l...r]
            // This is done by comparing its count up to r (prefixCounts[r+1][val])
            // with its count up to l-1 (prefixCounts[l][val]).
            // If the difference is greater than 0, 'val' is present in the subarray.
            if (prefixCounts[r + 1][val] - prefixCounts[l][val] > 0) {
                // 'val' is present in the current subarray
                if (lastSeenValue !== -1) {
                    // If we have seen a previous distinct number, calculate the difference
                    minDiff = Math.min(minDiff, val - lastSeenValue);
                }
                // Update lastSeenValue to the current 'val'
                lastSeenValue = val;
            }
        }

        // If minDiff is still Infinity, it means fewer than two distinct numbers were found
        if (minDiff === Infinity) {
            results.push(-1);
        } else {
            results.push(minDiff);
        }
    }

    return results;
};