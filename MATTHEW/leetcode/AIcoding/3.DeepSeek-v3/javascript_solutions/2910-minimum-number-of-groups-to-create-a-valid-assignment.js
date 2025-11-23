var minGroupsForValidAssignment = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const counts = Object.values(freq);
    const minCount = Math.min(...counts);

    for (let k = minCount + 1; k >= 1; k--) {
        let total = 0;
        for (const count of counts) {
            const q = Math.floor(count / k);
            const r = count % k;
            if (r <= q) {
                total += q + (r > 0 ? 1 : 0);
            } else {
                total = -1;
                break;
            }
        }
        if (total !== -1) {
            return total;
        }
    }
    return -1;
};