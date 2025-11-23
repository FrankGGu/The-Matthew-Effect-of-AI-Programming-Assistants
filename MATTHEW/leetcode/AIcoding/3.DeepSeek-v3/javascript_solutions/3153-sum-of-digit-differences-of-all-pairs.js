var sumDigitDifferences = function(nums) {
    const digitCounts = Array(10).fill().map(() => Array(10).fill(0));
    for (const num of nums) {
        let temp = num;
        let pos = 0;
        while (temp > 0) {
            const digit = temp % 10;
            digitCounts[pos][digit]++;
            temp = Math.floor(temp / 10);
            pos++;
        }
    }
    let total = 0;
    for (const posDigits of digitCounts) {
        for (let i = 0; i < 10; i++) {
            for (let j = i + 1; j < 10; j++) {
                total += posDigits[i] * posDigits[j];
            }
        }
    }
    return total;
};