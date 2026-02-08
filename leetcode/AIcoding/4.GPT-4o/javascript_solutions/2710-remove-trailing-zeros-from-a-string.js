var removeTrailingZeros = function(num) {
    let i = num.length - 1;
    while (i >= 0 && num[i] === '0') {
        i--;
    }
    return num.slice(0, i + 1);
};