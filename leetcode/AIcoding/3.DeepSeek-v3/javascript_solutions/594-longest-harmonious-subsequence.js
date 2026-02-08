var findLHS = function(nums) {
    const freq = {};
    let max = 0;

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    for (const key in freq) {
        const num = parseInt(key);
        if (freq[num + 1]) {
            max = Math.max(max, freq[num] + freq[num + 1]);
        }
    }

    return max;
};