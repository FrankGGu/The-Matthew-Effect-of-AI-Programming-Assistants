var maxEqualFreq = function(nums) {
    const count = new Map(), freq = new Map();
    let maxFreq = 0, maxLen = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (count.has(num)) {
            const oldFreq = count.get(num);
            count.set(num, oldFreq + 1);
            freq.set(oldFreq, freq.get(oldFreq) - 1);
            if (freq.get(oldFreq) === 0) freq.delete(oldFreq);
            freq.set(oldFreq + 1, (freq.get(oldFreq + 1) || 0) + 1);
        } else {
            count.set(num, 1);
            freq.set(1, (freq.get(1) || 0) + 1);
        }

        maxFreq = Math.max(maxFreq, count.get(num));

        if (freq.size === 1) {
            const onlyFreq = [...freq.keys()][0];
            if (onlyFreq === 1 || freq.get(onlyFreq) * onlyFreq === i + 1) {
                maxLen = i + 1;
            }
        } else if (freq.size === 2) {
            const [f1, f2] = [...freq.keys()];
            const [c1, c2] = [freq.get(f1), freq.get(f2)];
            if ((f1 === 1 && c1 === 1) || (f2 === 1 && c2 === 1) || (Math.abs(f1 - f2) === 1 && (c1 === 1 || c2 === 1))) {
                maxLen = i + 1;
            }
        }
    }

    return maxLen;
};