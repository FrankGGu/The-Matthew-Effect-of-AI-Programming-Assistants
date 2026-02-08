var findEvenNumbers = function(digits) {
    const result = new Set();
    const n = digits.length;

    for (let i = 0; i < n; i++) {
        if (digits[i] === 0) continue;
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            for (let k = 0; k < n; k++) {
                if (i === k || j === k || digits[k] % 2 !== 0) continue;
                const num = digits[i] * 100 + digits[j] * 10 + digits[k];
                result.add(num);
            }
        }
    }

    return Array.from(result).sort((a, b) => a - b);
};