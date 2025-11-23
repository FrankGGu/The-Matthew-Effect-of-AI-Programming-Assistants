var maxEqualFreq = function(nums) {
    let freq = new Map();
    let count = new Map();
    let maxLen = 0;

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];

        if (freq.has(num)) {
            let f = freq.get(num);
            count.set(f, count.get(f) - 1);
            if (count.get(f) === 0) {
                count.delete(f);
            }
            freq.set(num, f + 1);
            if (!count.has(f + 1)) {
                count.set(f + 1, 0);
            }
            count.set(f + 1, count.get(f + 1) + 1);
        } else {
            freq.set(num, 1);
            if (!count.has(1)) {
                count.set(1, 0);
            }
            count.set(1, count.get(1) + 1);
        }

        if (count.size === 1) {
            let f = count.keys().next().value;
            if (f === 1 || count.get(f) === 1) {
                maxLen = i + 1;
            }
        } else if (count.size === 2) {
            let keys = Array.from(count.keys());
            let f1 = keys[0];
            let f2 = keys[1];
            if ((f1 === 1 && count.get(f1) === 1) || (f2 === 1 && count.get(f2) === 1)) {
                maxLen = i + 1;
            } else if ((f1 - f2 === 1 && count.get(f1) === 1) || (f2 - f1 === 1 && count.get(f2) === 1)) {
                 maxLen = i + 1;
            }
        }
    }

    return maxLen;
};