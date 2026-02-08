var reorderedPowerOf2 = function(n) {
    const countDigits = (num) => {
        const counts = new Array(10).fill(0);
        const str = String(num);
        for (const digit of str) {
            counts[parseInt(digit)]++;
        }
        return counts;
    };

    const targetCounts = countDigits(n);

    for (let i = 0; i < 31; i++) {
        const powerOf2 = 1 << i;
        const powerOf2Counts = countDigits(powerOf2);
        if (JSON.stringify(powerOf2Counts) === JSON.stringify(targetCounts)) {
            return true;
        }
    }

    return false;
};