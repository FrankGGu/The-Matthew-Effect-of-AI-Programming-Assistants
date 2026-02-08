var minOperations = function(nums, k) {
    let totalSum = nums.reduce((a, b) => a + b, 0);
    let remainder = totalSum % k;
    if (remainder === 0) return 0;

    let prefixSum = 0;
    let prefixRemainders = new Map();
    prefixRemainders.set(0, -1);
    let minOps = Infinity;

    for (let i = 0; i < nums.length; i++) {
        prefixSum += nums[i];
        let currentRem = prefixSum % k;
        let targetRem = (currentRem - remainder + k) % k;

        if (prefixRemainders.has(targetRem)) {
            let start = prefixRemainders.get(targetRem);
            minOps = Math.min(minOps, i - start);
        }

        if (!prefixRemainders.has(currentRem)) {
            prefixRemainders.set(currentRem, i);
        }
    }

    return minOps === Infinity ? -1 : minOps;
};