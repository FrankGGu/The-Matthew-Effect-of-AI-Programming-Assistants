var canDistribute = function(nums, quantity) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const counts = Object.values(freq).sort((a, b) => b - a);
    quantity.sort((a, b) => b - a);

    const m = quantity.length;
    const n = counts.length;

    const backtrack = (idx) => {
        if (idx === m) return true;
        for (let i = 0; i < n; i++) {
            if (counts[i] >= quantity[idx]) {
                counts[i] -= quantity[idx];
                if (backtrack(idx + 1)) {
                    return true;
                }
                counts[i] += quantity[idx];
            }
        }
        return false;
    };

    return backtrack(0);
};