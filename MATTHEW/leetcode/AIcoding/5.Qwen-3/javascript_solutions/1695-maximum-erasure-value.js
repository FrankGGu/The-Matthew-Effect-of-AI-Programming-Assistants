function maximumErasureValue(nums, costs) {
    let left = 0;
    let maxVal = 0;
    let currentSum = 0;
    const freq = {};

    for (let right = 0; right < nums.length; right++) {
        while (freq[nums[right]] > 0) {
            freq[nums[left]]--;
            currentSum -= costs[left];
            left++;
        }
        freq[nums[right]] = (freq[nums[right]] || 0) + 1;
        currentSum += costs[right];
        maxVal = Math.max(maxVal, currentSum);
    }

    return maxVal;
}