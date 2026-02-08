var minLengthAfterRemovals = function(nums) {
    const n = nums.length;
    let maxFreq = 0;
    const freq = {};

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
        if (freq[num] > maxFreq) {
            maxFreq = freq[num];
        }
    }

    if (maxFreq <= n / 2) {
        return n % 2;
    } else {
        return 2 * maxFreq - n;
    }
};