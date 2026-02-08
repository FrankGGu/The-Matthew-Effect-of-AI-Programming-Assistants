var minPartitions = function(n) {
    let maxDigit = 0;
    for (let i = 0; i < n.length; i++) {
        const digit = parseInt(n[i]);
        if (digit > maxDigit) {
            maxDigit = digit;
        }
    }
    return maxDigit;
};