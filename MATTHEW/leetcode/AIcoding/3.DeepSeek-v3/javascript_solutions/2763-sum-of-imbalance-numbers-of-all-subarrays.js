var sumImbalanceNumbers = function(nums) {
    let total = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        const seen = new Set();
        seen.add(nums[i]);
        let currentImbalance = 0;
        for (let j = i + 1; j < n; j++) {
            const num = nums[j];
            if (!seen.has(num)) {
                const hasPrev = seen.has(num - 1);
                const hasNext = seen.has(num + 1);
                if (!hasPrev && !hasNext) {
                    currentImbalance++;
                } else if (hasPrev && hasNext) {
                    currentImbalance--;
                }
                seen.add(num);
            }
            total += currentImbalance;
        }
    }
    return total;
};