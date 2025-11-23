var topKFrequent = function(nums, k) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const bucket = [];
    for (let i = 0; i <= nums.length; i++) {
        bucket.push([]);
    }

    for (const [num, freq] of freqMap) {
        bucket[freq].push(num);
    }

    const result = [];
    for (let i = bucket.length - 1; i >= 0 && result.length < k; i--) {
        if (bucket[i].length > 0) {
            result.push(...bucket[i]);
        }
    }

    return result.slice(0, k);
};