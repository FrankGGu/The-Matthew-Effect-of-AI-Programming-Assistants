var numberOfSubarrays = function(nums, k) {
    let count = 0;
    let prefixSum = 0;
    const map = new Map();
    map.set(0, 1);

    for (let num of nums) {
        prefixSum += num % 2;
        if (map.has(prefixSum - k)) {
            count += map.get(prefixSum - k);
        }
        map.set(prefixSum, (map.get(prefixSum) || 0) + 1);
    }

    return count;
};