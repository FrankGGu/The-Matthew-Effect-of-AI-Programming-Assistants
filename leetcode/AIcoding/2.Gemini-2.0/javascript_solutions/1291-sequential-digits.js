var sequentialDigits = function(low, high) {
    const result = [];
    for (let start = 1; start <= 9; start++) {
        let num = start;
        let nextDigit = start + 1;
        while (num <= high && nextDigit <= 10) {
            if (num >= low) {
                result.push(num);
            }
            if (nextDigit === 10) break;
            num = num * 10 + nextDigit;
            nextDigit++;
        }
    }
    return result.sort((a, b) => a - b);
};