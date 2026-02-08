var sequentialDigits = function(low, high) {
    const result = [];
    const digits = '123456789';

    for (let length = 2; length <= 9; length++) {
        for (let start = 0; start <= 9 - length; start++) {
            const num = parseInt(digits.substring(start, start + length), 10);
            if (num > high) {
                break;
            }
            if (num >= low) {
                result.push(num);
            }
        }
    }

    return result.sort((a, b) => a - b);
};