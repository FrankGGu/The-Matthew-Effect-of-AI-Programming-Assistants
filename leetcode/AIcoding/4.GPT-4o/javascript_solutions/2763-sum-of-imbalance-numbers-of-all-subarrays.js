var sumOfImbalanceNumbers = function(nums) {
    let n = nums.length;
    let totalImbalance = 0;

    for (let i = 0; i < n; i++) {
        let imbalanceCount = 0;
        let count = new Map();

        for (let j = i; j < n; j++) {
            if (!count.has(nums[j])) {
                count.set(nums[j], 0);
            }
            count.set(nums[j], count.get(nums[j]) + 1);

            let currentMax = Math.max(...count.keys());
            let currentMin = Math.min(...count.keys());

            if (currentMax - currentMin > 1) {
                imbalanceCount++;
            }
            totalImbalance += imbalanceCount;
        }
    }

    return totalImbalance;
};