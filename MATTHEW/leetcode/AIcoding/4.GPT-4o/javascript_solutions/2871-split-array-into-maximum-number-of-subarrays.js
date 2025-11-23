function maxSubarrays(nums) {
    let count = 0;
    let currentMax = 0;

    for (let i = 0; i < nums.length; i++) {
        currentMax = Math.max(currentMax, nums[i]);
        if (currentMax === i + 1) {
            count++;
        }
    }

    return count;
}