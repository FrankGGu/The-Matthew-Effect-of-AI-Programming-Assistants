function maximumGap(nums) {
    if (nums.length < 2) return 0;

    const n = nums.length;
    const minVal = Math.min(...nums);
    const maxVal = Math.max(...nums);

    if (minVal === maxVal) return 0;

    const bucketSize = Math.floor((maxVal - minVal) / (n - 1)) || 1;
    const buckets = Array.from({ length: n }, () => ({ min: Infinity, max: -Infinity }));

    for (const num of nums) {
        if (num === minVal || num === maxVal) continue;
        const index = Math.floor((num - minVal) / bucketSize);
        buckets[index].min = Math.min(buckets[index].min, num);
        buckets[index].max = Math.max(buckets[index].max, num);
    }

    let maxGap = 0;
    let prev = minVal;

    for (const bucket of buckets) {
        if (bucket.min === Infinity) continue;
        maxGap = Math.max(maxGap, bucket.min - prev);
        prev = bucket.max;
    }

    maxGap = Math.max(maxGap, maxVal - prev);

    return maxGap;
}