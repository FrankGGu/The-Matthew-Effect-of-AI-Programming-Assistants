function minOperations(nums, k) {
    let currentSum = 0, minOps = Infinity;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (currentSum >= k) {
            minOps = Math.min(minOps, right - left + 1);
            currentSum -= nums[left++];
        }
    }

    return minOps === Infinity ? -1 : minOps;
}