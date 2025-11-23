function minDeletions(nums, divisors) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const maxFreq = Math.max(...freq.values());

    let result = nums.length;

    for (const d of divisors) {
        const count = {};
        for (const [num, freqNum] of freq.entries()) {
            if (num % d === 0) {
                count[d] = (count[d] || 0) + freqNum;
            }
        }
        if (count[d] === undefined) continue;
        result = Math.min(result, nums.length - count[d]);
    }

    return result;
}