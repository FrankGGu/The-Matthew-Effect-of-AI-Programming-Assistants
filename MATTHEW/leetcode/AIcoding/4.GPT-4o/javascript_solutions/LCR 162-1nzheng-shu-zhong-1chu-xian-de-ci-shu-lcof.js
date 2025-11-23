var countDigitOne = function(n) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        count += String(i).split('').filter(digit => digit === '1').length;
    }
    return count;
};