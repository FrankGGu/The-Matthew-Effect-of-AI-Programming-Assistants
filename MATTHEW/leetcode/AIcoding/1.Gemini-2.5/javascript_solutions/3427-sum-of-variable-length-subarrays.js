var sumOddLengthSubarrays = function(arr) {
    let totalSum = 0;
    const n = arr.length;

    for (let i = 0; i < n; i++) {
        // Number of possible start positions for a subarray containing arr[i]
        // These are indices 0, 1, ..., i (i + 1 choices)
        const leftChoices = i + 1;

        // Number of possible end positions for a subarray containing arr[i]
        // These are indices i, i + 1, ..., n - 1 (n - i choices)
        const rightChoices = n - i;

        // Total number of subarrays that contain arr[i]
        const totalSubarraysContainingI = leftChoices * rightChoices;

        // Number of odd-length subarrays that contain arr[i]
        // Roughly half of the subarrays will have odd length.
        // Math.ceil ensures we get the correct count when totalSubarraysContainingI is odd.
        const oddLengthSubarraysContainingI = Math.ceil(totalSubarraysContainingI / 2);

        // Add arr[i] multiplied by its occurrences in odd-length subarrays to the total sum
        totalSum += arr[i] * oddLengthSubarraysContainingI;
    }

    return totalSum;
};