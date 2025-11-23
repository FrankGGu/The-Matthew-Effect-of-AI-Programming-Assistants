var minPartitions = function(n) {
    let maxDigit = 0;
    for (let digit of n) {
        maxDigit = Math.max(maxDigit, parseInt(digit));
    }
    return maxDigit;
};