var maximumGoodSubarraySum = function(nums, k) {
    let maxSum = -Infinity;
    let currentPrefixSum = 0; // Represents P[i], the sum of nums[0...i-1]
    // valToMinPrefix stores value -> minimum P[idx] for nums[idx] == value
    const valToMinPrefix = new Map();

    for (let i = 0; i < nums.length; i++) {
        const currentVal = nums[i];

        // Before checking for targets, update the map for currentVal.
        // This ensures that currentVal can be considered as nums[l] for l=i,
        // allowing single-element subarrays when k=0.
        // currentPrefixSum holds P[i] at this point.
        valToMinPrefix.set(currentVal, Math.min(valToMinPrefix.get(currentVal) || Infinity, currentPrefixSum));

        // Calculate potential starting values for nums[l]
        const target1 = currentVal - k;
        const target2 = currentVal + k;

        // Check if target1 exists in the map
        if (valToMinPrefix.has(target1)) {
            const minP_l = valToMinPrefix.get(target1);
            // The sum of nums[l...i] is P[i+1] - P[l]
            // P[i+1] is currentPrefixSum + currentVal
            maxSum = Math.max(maxSum, currentPrefixSum + currentVal - minP_l);
        }

        // Check if target2 exists in the map
        if (valToMinPrefix.has(target2)) {
            const minP_l = valToMinPrefix.get(target2);
            // The sum of nums[l...i] is P[i+1] - P[l]
            maxSum = Math.max(maxSum, currentPrefixSum + currentVal - minP_l);
        }

        // Update currentPrefixSum for the next iteration (it becomes P[i+1])
        currentPrefixSum += currentVal;
    }

    // If no good subarray was found, maxSum will still be -Infinity.
    // The problem states to return 0 in this case.
    return maxSum === -Infinity ? 0 : maxSum;
};