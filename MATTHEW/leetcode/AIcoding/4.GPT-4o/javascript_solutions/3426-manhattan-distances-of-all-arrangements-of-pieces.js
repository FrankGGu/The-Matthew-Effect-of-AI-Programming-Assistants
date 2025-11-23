function distanceSum(nums) {
    const n = nums.length;
    let totalDistance = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            totalDistance += Math.abs(nums[i] - nums[j]) * (i - j);
        }
    }

    return totalDistance;
}