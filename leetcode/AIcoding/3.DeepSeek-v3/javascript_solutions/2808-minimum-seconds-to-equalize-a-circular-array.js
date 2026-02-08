var minimumSeconds = function(nums) {
    const valueIndices = new Map();
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (!valueIndices.has(num)) {
            valueIndices.set(num, []);
        }
        valueIndices.get(num).push(i);
    }

    let minTime = Infinity;
    for (const indices of valueIndices.values()) {
        let maxGap = 0;
        const n = nums.length;
        for (let i = 1; i < indices.length; i++) {
            const gap = indices[i] - indices[i - 1] - 1;
            maxGap = Math.max(maxGap, gap);
        }
        const circularGap = (n - indices[indices.length - 1] + indices[0] - 1);
        maxGap = Math.max(maxGap, circularGap);
        const time = Math.ceil(maxGap / 2);
        minTime = Math.min(minTime, time);
    }
    return minTime;
};