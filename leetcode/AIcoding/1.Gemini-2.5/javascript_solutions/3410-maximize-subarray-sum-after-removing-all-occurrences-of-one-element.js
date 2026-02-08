var maximumSubarraySum = function(nums) {
    let overallMaxSum = 0; // Initialize to 0, as an empty subarray has sum 0.

    // Helper function for Kadane's algorithm
    // Returns the maximum subarray sum.
    // If all possible non-empty subarray sums are negative, it returns 0 (representing an empty subarray).
    function kadane(arr) {
        if (arr.length === 0) {
            return 0;
        }

        // Standard Kadane's algorithm to find the maximum sum of a non-empty subarray.
        // This handles cases where all numbers are negative by returning the largest single negative number.
        let maxSoFar = arr[0];
        let currentMax = arr[0];

        for (let i = 1; i < arr.length; i++) {
            currentMax = Math.max(arr[i], currentMax + arr[i]);
            maxSoFar = Math.max(maxSoFar, currentMax);
        }

        // According to common LeetCode interpretation, if all non-empty subarray sums are negative,
        // an empty subarray (sum 0) is considered the maximum.
        return Math.max(0, maxSoFar);
    }

    // Get all unique elements in the input array.
    const uniqueElements = Array.from(new Set(nums));

    // Iterate through each unique element. For each element, consider removing all its occurrences.
    for (const valToRemove of uniqueElements) {
        const tempArr = [];
        // Construct a temporary array by excluding all occurrences of `valToRemove`.
        for (const num of nums) {
            if (num !== valToRemove) {
                tempArr.push(num);
            }
        }

        // Calculate the maximum subarray sum for the modified array.
        // The `kadane` function handles empty arrays and all-negative arrays correctly.
        overallMaxSum = Math.max(overallMaxSum, kadane(tempArr));
    }

    return overallMaxSum;
};