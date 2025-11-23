var minPartitions = function(s) {
    let n = s.length;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === '9') return 9;
    }
    let maxDigit = 0;
    for (let i = 0; i < n; i++) {
        maxDigit = Math.max(maxDigit, parseInt(s[i]));
    }
    return maxDigit;
};