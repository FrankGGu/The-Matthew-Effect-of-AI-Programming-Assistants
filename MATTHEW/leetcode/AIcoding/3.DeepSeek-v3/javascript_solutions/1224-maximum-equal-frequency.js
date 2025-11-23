var maxEqualFreq = function(nums) {
    const freq = {};
    const count = {};
    let maxFreq = 0;
    let res = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (count[num]) {
            freq[count[num]]--;
        }
        count[num] = (count[num] || 0) + 1;
        maxFreq = Math.max(maxFreq, count[num]);
        freq[count[num]] = (freq[count[num]] || 0) + 1;

        const isValid = (maxFreq === 1) ||
                        (freq[maxFreq] * maxFreq + freq[maxFreq - 1] * (maxFreq - 1) === i + 1 && freq[maxFreq] === 1) ||
                        (freq[1] === 1 && freq[maxFreq] * maxFreq === i);
        if (isValid) {
            res = i + 1;
        }
    }

    return res;
};