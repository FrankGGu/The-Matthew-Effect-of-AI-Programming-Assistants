var minimumIncompatibility = function(nums, k) {
    const n = nums.length;
    const groupSize = n / k;
    const masks = new Map();
    for (let i = 0; i < (1 << groupSize); i++) {
        if (bitCount(i) !== groupSize) continue;
        let subset = [];
        for (let j = 0; j < groupSize; j++) {
            if ((i >> j) & 1) {
                subset.push(j);
            }
        }
        let minVal = Infinity;
        let maxVal = -Infinity;
        let set = new Set();
        let valid = true;
        for (let index of subset) {
            let val = nums[index];
            if (set.has(val)) {
                valid = false;
                break;
            }
            set.add(val);
            minVal = Math.min(minVal, val);
            maxVal = Math.max(maxVal, val);
        }
        if (valid) {
            masks.set(i, maxVal - minVal);
        }
    }

    const dp = new Map();
    dp.set(0, 0);

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp.has(mask) === false) continue;
        for (let submask = 0; submask < (1 << n); submask++) {
            if ((mask & submask) !== 0) continue;
            if (bitCount(submask) !== groupSize) continue;

            let indices = [];
            for (let i = 0; i < n; i++) {
                if ((submask >> i) & 1) {
                    indices.push(i);
                }
            }

            let numsSubset = [];
            for (let idx of indices) {
                numsSubset.push(nums[idx]);
            }

            let submaskIndex = 0;
            for (let i = 0; i < groupSize; i++) {
                submaskIndex |= (1 << i);
            }

            let newMask = mask | submask;
            let sortedNums = [...numsSubset].sort((a, b) => a - b);
            let valid = true;
            for (let i = 1; i < groupSize; i++) {
                if (sortedNums[i] === sortedNums[i - 1]) {
                    valid = false;
                    break;
                }
            }

            if (!valid) continue;

            let incompatibility = sortedNums[groupSize - 1] - sortedNums[0];
            if (!dp.has(newMask) || dp.get(newMask) > dp.get(mask) + incompatibility) {
                dp.set(newMask, dp.get(mask) + incompatibility);
            }
        }
    }

    if (dp.has((1 << n) - 1)) {
        return dp.get((1 << n) - 1);
    } else {
        return -1;
    }

    function bitCount(n) {
        let count = 0;
        while (n > 0) {
            count += (n & 1);
            n >>= 1;
        }
        return count;
    }
};