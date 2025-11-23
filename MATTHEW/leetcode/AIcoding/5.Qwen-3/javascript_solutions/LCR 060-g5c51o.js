function topKFrequent(nums, k) {
    const count = {};
    const freq = Array.from({ length: nums.length + 1 }, () => []);

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const num in count) {
        const freqNum = count[num];
        freq[freqNum].push(num);
    }

    const result = [];
    for (let i = freq.length - 1; i > 0; i--) {
        for (const num of freq[i]) {
            result.push(num);
            if (result.length === k) {
                return result;
            }
        }
    }

    return result;
}