var sumImbalanceNumbers = function(nums) {
    const n = nums.length;
    let totalImbalance = 0;

    for (let i = 0; i < n; i++) {
        const uniqueElements = new Set();
        let currentImbalanceCount = 0;

        for (let j = i; j < n; j++) {
            const currentNum = nums[j];

            if (!uniqueElements.has(currentNum)) {
                // If currentNum + 1 is not in the set, then currentNum forms a new imbalance point.
                if (!uniqueElements.has(currentNum + 1)) {
                    currentImbalanceCount++;
                }
                // If currentNum - 1 is in the set, then (currentNum - 1) was an imbalance point
                // (because currentNum was not present). Now that currentNum is added,
                // (currentNum - 1) no longer forms an imbalance point.
                if (uniqueElements.has(currentNum - 1)) {
                    currentImbalanceCount--;
                }
                uniqueElements.add(currentNum);
            }
            // Add the imbalance count for the current subarray nums[i...j]
            totalImbalance += currentImbalanceCount;
        }
    }

    return totalImbalance;
};