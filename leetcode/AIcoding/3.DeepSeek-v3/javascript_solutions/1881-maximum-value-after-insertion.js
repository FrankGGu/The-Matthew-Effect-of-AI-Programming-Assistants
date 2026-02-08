var maxValue = function(n, x) {
    const isNegative = n[0] === '-';
    let i = isNegative ? 1 : 0;
    while (i < n.length) {
        const digit = parseInt(n[i]);
        if ((isNegative && digit > x) || (!isNegative && digit < x)) {
            break;
        }
        i++;
    }
    return n.slice(0, i) + x.toString() + n.slice(i);
};