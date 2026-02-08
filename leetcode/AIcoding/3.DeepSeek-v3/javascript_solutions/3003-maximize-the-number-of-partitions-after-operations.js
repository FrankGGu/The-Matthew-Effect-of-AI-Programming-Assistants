var maxPartitionsAfterOperations = function(s, k) {
    const n = s.length;
    let memo = new Map();

    function dp(index, mask, canChange) {
        if (index === n) {
            return 0;
        }
        const key = `${index},${mask},${canChange}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let res = 0;
        const newMask = mask | (1 << (s.charCodeAt(index) - 'a'.charCodeAt(0)));
        const bitCount = countBits(newMask);

        if (bitCount > k) {
            res = 1 + dp(index + 1, 1 << (s.charCodeAt(index) - 'a'.charCodeAt(0)), canChange);
        } else {
            res = dp(index + 1, newMask, canChange);
        }

        if (canChange) {
            for (let c = 0; c < 26; c++) {
                const tempMask = mask | (1 << c);
                const tempBitCount = countBits(tempMask);

                if (tempBitCount > k) {
                    res = Math.max(res, 1 + dp(index + 1, 1 << c, false));
                } else {
                    res = Math.max(res, dp(index + 1, tempMask, false));
                }
            }
        }

        memo.set(key, res);
        return res;
    }

    function countBits(mask) {
        let count = 0;
        while (mask > 0) {
            count += mask & 1;
            mask >>= 1;
        }
        return count;
    }

    return 1 + dp(0, 0, true);
};