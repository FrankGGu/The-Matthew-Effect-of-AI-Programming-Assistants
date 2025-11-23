var reductionOperations = function(nums) {
    let count = 0;
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const keys = Object.keys(freq).map(Number).sort((a, b) => b - a);
    for (let i = 1; i < keys.length; i++) {
        count += freq[keys[i]] * i;
    }
    return count;
};