function countGoodTriplets(nums, a, b, c) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if (Math.abs(nums[i] - nums[j]) <= a &&
                    Math.abs(nums[j] - nums[k]) <= b &&
                    Math.abs(nums[i] - nums[k]) <= c) {
                    count++;
                }
            }
        }
    }
    return count;
}