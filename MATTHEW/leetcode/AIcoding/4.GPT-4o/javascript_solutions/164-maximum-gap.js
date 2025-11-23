var maximumGap = function(nums) {
    if (nums.length < 2) return 0;
    let max = Math.max(...nums);
    let min = Math.min(...nums);
    let bucketSize = Math.ceil((max - min) / (nums.length - 1)) || 1;
    let bucketCount = Math.floor((max - min) / bucketSize) + 1;
    let buckets = Array.from({length: bucketCount}, () => [Infinity, -Infinity]);

    for (let num of nums) {
        let idx = Math.floor((num - min) / bucketSize);
        buckets[idx][0] = Math.min(buckets[idx][0], num);
        buckets[idx][1] = Math.max(buckets[idx][1], num);
    }

    let maxGap = 0;
    let previousMax = min;

    for (let [minVal, maxVal] of buckets) {
        if (minVal === Infinity) continue;
        maxGap = Math.max(maxGap, minVal - previousMax);
        previousMax = maxVal;
    }

    return maxGap;
};