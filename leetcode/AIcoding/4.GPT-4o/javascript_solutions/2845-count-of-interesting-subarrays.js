function countInterestingSubarrays(nums, modulo) {
    const prefixCount = new Map();
    prefixCount.set(0, 1);

    let count = 0, prefixSum = 0;

    for (const num of nums) {
        if (num % modulo === 0) {
            prefixSum++;
        }
        count += prefixCount.get(prefixSum - 1) || 0;
        prefixCount.set(prefixSum, (prefixCount.get(prefixSum) || 0) + 1);
    }

    return count;
}