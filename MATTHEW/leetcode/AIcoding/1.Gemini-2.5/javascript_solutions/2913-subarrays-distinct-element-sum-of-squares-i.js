var sumCounts = function(nums) {
    let totalSum = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let distinctElements = new Set();
        for (let j = i; j < n; j++) {
            distinctElements.add(nums[j]);
            const count = distinctElements.size;
            totalSum += (count * count);
        }
    }

    return totalSum;
};