var topKFrequent = function(nums, k) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    // Create buckets where index is frequency and value is an array of numbers
    // Max frequency can be nums.length, so size is nums.length + 1
    const buckets = Array(nums.length + 1).fill(null).map(() => []);

    for (const [num, freq] of freqMap.entries()) {
        buckets[freq].push(num);
    }

    const result = [];
    // Iterate from highest frequency down to 1
    for (let i = buckets.length - 1; i >= 0; i--) {
        if (buckets[i].length > 0) {
            for (const num of buckets[i]) {
                result.push(num);
                if (result.length === k) {
                    return result;
                }
            }
        }
    }

    return result;
};