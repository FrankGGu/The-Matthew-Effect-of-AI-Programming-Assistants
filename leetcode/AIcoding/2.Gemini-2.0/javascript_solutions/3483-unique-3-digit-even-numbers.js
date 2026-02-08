var findEvenNumbers = function(digits) {
    const set = new Set();
    const n = digits.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            for (let k = 0; k < n; k++) {
                if (i === k || j === k) continue;

                const num = digits[i] * 100 + digits[j] * 10 + digits[k];
                if (num >= 100 && num % 2 === 0) {
                    set.add(num);
                }
            }
        }
    }

    const result = Array.from(set).sort((a, b) => a - b);
    return result;
};