var maxEqualFrequency = function(nums) {
    const count = new Map();
    const freq = new Map();
    let maxFreq = 0;
    let result = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const prevCount = count.get(num) || 0;
        if (prevCount > 0) {
            freq.set(prevCount, freq.get(prevCount) - 1);
            if (freq.get(prevCount) === 0) {
                freq.delete(prevCount);
            }
        }
        count.set(num, prevCount + 1);
        freq.set(prevCount + 1, (freq.get(prevCount + 1) || 0) + 1);
        maxFreq = Math.max(maxFreq, prevCount + 1);

        if (freq.size === 1) {
            if (maxFreq === 1 || freq.has(maxFreq) && freq.get(maxFreq) === 1) {
                result = i + 1;
            }
        } else if (freq.size === 2) {
            const keys = Array.from(freq.keys());
            const [a, b] = keys;
            if ((a === 1 && freq.get(a) === 1) || (b === 1 && freq.get(b) === 1)) {
                result = i + 1;
            } else if (Math.abs(a - b) === 1) {
                if ((freq.get(a) === 1 && a > b) || (freq.get(b) === 1 && b > a)) {
                    result = i + 1;
                }
            }
        }
    }

    return result;
};