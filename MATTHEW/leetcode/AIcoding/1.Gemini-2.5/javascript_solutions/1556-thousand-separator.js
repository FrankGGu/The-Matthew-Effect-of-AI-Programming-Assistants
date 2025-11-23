var thousandSeparator = function(n) {
    const s = n.toString();
    const result = [];
    let digitCount = 0;

    for (let i = s.length - 1; i >= 0; i--) {
        result.push(s[i]);
        digitCount++;
        if (digitCount === 3 && i > 0) {
            result.push('.');
            digitCount = 0;
        }
    }

    return result.reverse().join('');
};