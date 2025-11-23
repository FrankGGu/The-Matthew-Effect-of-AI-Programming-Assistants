var isPossibleDivide = function(nums, k) {
    if (nums.length % k !== 0) return false;

    const count = new Map();

    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const sorted = [...count.keys()].sort((a, b) => a - b);

    for (const num of sorted) {
        if (count.get(num) > 0) {
            const freq = count.get(num);
            for (let i = 0; i < k; i++) {
                const current = num + i;
                if (count.get(current) < freq) return false;
                count.set(current, count.get(current) - freq);
            }
        }
    }

    return true;
};