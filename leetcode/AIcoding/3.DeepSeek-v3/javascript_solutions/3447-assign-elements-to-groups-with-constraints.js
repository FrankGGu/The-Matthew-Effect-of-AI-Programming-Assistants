var minGroupsForValidAssignment = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const counts = Object.values(freq);
    const minCount = Math.min(...counts);

    for (let k = minCount + 1; k >= 1; k--) {
        let total = 0;
        for (const c of counts) {
            const q = Math.floor(c / k);
            const r = c % k;
            if (q < r) {
                total = 0;
                break;
            }
            total += q;
        }
        if (total > 0) {
            return total;
        }
    }
    return -1;
};