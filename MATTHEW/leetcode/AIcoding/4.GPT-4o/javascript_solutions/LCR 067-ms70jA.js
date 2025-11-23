var findMaximumXOR = function(nums) {
    let max = 0, mask = 0;
    for (let i = 31; i >= 0; i--) {
        mask |= (1 << i);
        const prefixes = new Set();
        for (const num of nums) {
            prefixes.add(num & mask);
        }
        const candidate = max | (1 << i);
        for (const prefix of prefixes) {
            if (prefixes.has(candidate ^ prefix)) {
                max = candidate;
                break;
            }
        }
    }
    return max;
};