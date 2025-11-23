var excellentPairs = function(nums, k) {
    function countSetBits(n) {
        let count = 0;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }

    const uniqueNums = new Set(nums);

    const bitFrequencies = new Array(31).fill(0);

    for (const num of uniqueNums) {
        const bits = countSetBits(num);
        bitFrequencies[bits]++;
    }

    let excellentPairsCount = 0;

    for (let b1 = 0; b1 <= 30; b1++) {
        if (bitFrequencies[b1] === 0) {
            continue;
        }
        for (let b2 = 0; b2 <= 30; b2++) {
            if (bitFrequencies[b2] === 0) {
                continue;
            }
            if (b1 + b2 >= k) {
                excellentPairsCount += bitFrequencies[b1] * bitFrequencies[b2];
            }
        }
    }

    return excellentPairsCount;
};