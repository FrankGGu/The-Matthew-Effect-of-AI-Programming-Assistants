var sequentialDigits = function(low, high) {
    const result = [];
    const digits = '123456789';

    for (let len = 1; len <= 9; len++) {
        for (let start = 0; start <= 9 - len; start++) {
            const num = parseInt(digits.slice(start, start + len));
            if (num >= low && num <= high) {
                result.push(num);
            }
        }
    }

    return result.sort((a, b) => a - b);
};