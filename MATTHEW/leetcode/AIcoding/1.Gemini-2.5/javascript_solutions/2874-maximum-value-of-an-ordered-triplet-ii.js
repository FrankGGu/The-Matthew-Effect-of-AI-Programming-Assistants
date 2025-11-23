var maximumTripletValue = function(nums) {
    let maxTripletValue = 0;
    let maxI = nums[0]; // Stores max(nums[x]) for x < j
    let maxIDiffJ = -Infinity; // Stores max(nums[x] - nums[y]) for x < y

    for (let k = 1; k < nums.length; k++) {
        // When we are at index k, nums[k] is a candidate for the third element.
        // We need to find max(nums[i] - nums[j]) for i < j < k.
        // The current maxIDiffJ holds max(nums[i] - nums[j]) where j is up to k-1.
        // So, we update maxTripletValue using the current maxIDiffJ and nums[k].
        maxTripletValue = Math.max(maxTripletValue, maxIDiffJ * nums[k]);

        // Now, prepare for the next iteration (k+1).
        // nums[k] will become a candidate for nums[j] in the next step.
        // So, we update maxIDiffJ using nums[k] as nums[j] and the current maxI.
        maxIDiffJ = Math.max(maxIDiffJ, maxI - nums[k]);

        // Also, nums[k] is a new candidate for maxI for future j's.
        maxI = Math.max(maxI, nums[k]);
    }

    return maxTripletValue;
};