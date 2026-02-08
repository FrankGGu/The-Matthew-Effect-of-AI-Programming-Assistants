var findOriginalArray = function(changed) {
    if (changed.length % 2 !== 0) return [];
    const freq = {};
    const result = [];
    changed.sort((a, b) => a - b);

    for (const num of changed) {
        freq[num] = (freq[num] || 0) + 1;
    }

    for (const num of changed) {
        if (freq[num] === 0) continue;
        const double = num * 2;
        if (!freq[double] || freq[double] === 0) return [];
        result.push(num);
        freq[num]--;
        freq[double]--;
    }

    return result;
};