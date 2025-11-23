var digitCount = function(num) {
    const n = num.length;
    const freq = new Array(10).fill(0);

    for (let i = 0; i < n; i++) {
        const digit = parseInt(num[i]);
        freq[digit]++;
    }

    for (let i = 0; i < n; i++) {
        const expectedCount = parseInt(num[i]);
        const actualCountOfDigit_i = freq[i];

        if (expectedCount !== actualCountOfDigit_i) {
            return false;
        }
    }

    return true;
};