function maxNumberSubarraysWithSumTarget(nums, target) {
    let count = 0;
    let prefixSum = 0;
    const sumSet = new Set();
    sumSet.add(0);
    for (const num of nums) {
        prefixSum += num;
        if (sumSet.has(prefixSum - target)) {
            count++;
            prefixSum = 0;
            sumSet.clear();
            sumSet.add(0);
        } else {
            sumSet.add(prefixSum);
        }
    }
    return count;
}