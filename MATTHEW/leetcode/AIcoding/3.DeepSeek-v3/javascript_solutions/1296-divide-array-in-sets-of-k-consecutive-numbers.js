var isPossibleDivide = function(nums, k) {
    if (nums.length % k !== 0) return false;
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    const sorted = Object.keys(count).map(Number).sort((a, b) => a - b);
    for (const num of sorted) {
        if (count[num] > 0) {
            const cnt = count[num];
            for (let i = 1; i < k; i++) {
                if (!count[num + i] || count[num + i] < cnt) {
                    return false;
                }
                count[num + i] -= cnt;
            }
        }
    }
    return true;
};