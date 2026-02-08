var maximumGap = function(nums) {
    if (nums.length < 2) return 0;

    let minVal = Math.min(...nums);
    let maxVal = Math.max(...nums);
    let n = nums.length;

    let bucketSize = Math.max(1, Math.floor((maxVal - minVal) / (n - 1)));
    let bucketCount = Math.floor((maxVal - minVal) / bucketSize) + 1;

    let buckets = new Array(bucketCount).fill().map(() => ({
        min: Infinity,
        max: -Infinity,
        used: false
    }));

    for (let num of nums) {
        let bucketIdx = Math.floor((num - minVal) / bucketSize);
        buckets[bucketIdx].min = Math.min(buckets[bucketIdx].min, num);
        buckets[bucketIdx].max = Math.max(buckets[bucketIdx].max, num);
        buckets[bucketIdx].used = true;
    }

    let maxGap = 0;
    let prevMax = minVal;

    for (let bucket of buckets) {
        if (!bucket.used) continue;
        maxGap = Math.max(maxGap, bucket.min - prevMax);
        prevMax = bucket.max;
    }

    return maxGap;
};