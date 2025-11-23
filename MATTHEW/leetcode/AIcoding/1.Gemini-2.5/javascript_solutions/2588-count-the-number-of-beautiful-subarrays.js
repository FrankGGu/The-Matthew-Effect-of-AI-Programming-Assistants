var numberOfSubarrays = function(nums, k) {
    let prefixOddCounts = new Map();
    prefixOddCounts.set(0, 1);
    let currentOddCount = 0;
    let beautifulSubarrays = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 !== 0) {
            currentOddCount++;
        }

        if (prefixOddCounts.has(currentOddCount - k)) {
            beautifulSubarrays += prefixOddCounts.get(currentOddCount - k);
        }

        prefixOddCounts.set(currentOddCount, (prefixOddCounts.get(currentOddCount) || 0) + 1);
    }

    return beautifulSubarrays;
};