function canDistribute(nums, quantity) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }
    const availableCounts = Array.from(freqMap.values());

    quantity.sort((a, b) => b - a);

    const memo = new Map();

    function backtrack(customerIdx, currentCounts) {
        if (customerIdx === quantity.length) {
            return true;
        }

        const sortedCounts = [...currentCounts].filter(c => c > 0).sort((a, b) => b - a);
        const key = `${customerIdx}-${sortedCounts.join(',')}`;

        if (memo.has(key)) {
            return memo.get(key);
        }

        const demand = quantity[customerIdx];

        for (let i = 0; i < currentCounts.length; i++) {
            if (currentCounts[i] >= demand) {
                currentCounts[i] -= demand;
                if (backtrack(customerIdx + 1, currentCounts)) {
                    memo.set(key, true);
                    return true;
                }
                currentCounts[i] += demand;
            }
        }

        memo.set(key, false);
        return false;
    }

    return backtrack(0, availableCounts);
}