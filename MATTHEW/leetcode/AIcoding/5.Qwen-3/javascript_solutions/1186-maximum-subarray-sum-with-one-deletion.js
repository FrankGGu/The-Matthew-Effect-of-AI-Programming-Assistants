function maximumSubarray(nums) {
    let maxEndingHere = 0;
    let maxSoFar = -Infinity;
    let maxDelete = -Infinity;

    for (let i = 0; i < nums.length; i++) {
        maxEndingHere = Math.max(nums[i], maxEndingHere + nums[i]);
        maxSoFar = Math.max(maxSoFar, maxEndingHere);

        if (i > 0) {
            maxDelete = Math.max(maxDelete + nums[i], maxSoFar);
        }

        maxSoFar = Math.max(maxSoFar, maxDelete);
    }

    return maxSoFar;
}