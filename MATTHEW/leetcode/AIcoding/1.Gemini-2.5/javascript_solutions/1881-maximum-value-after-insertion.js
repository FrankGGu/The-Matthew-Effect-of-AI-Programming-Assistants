var maxValue = function(n, x) {
    const xChar = x.toString();
    const isNegative = n[0] === '-';
    let result = '';
    let inserted = false;

    if (isNegative) {
        for (let i = 1; i < n.length; i++) {
            if (xChar < n[i]) {
                result = n.substring(0, i) + xChar + n.substring(i);
                inserted = true;
                break;
            }
        }
    } else {
        for (let i = 0; i < n.length; i++) {
            if (xChar > n[i]) {
                result = n.substring(0, i) + xChar + n.substring(i);
                inserted = true;
                break;
            }
        }
    }

    if (!inserted) {
        result = n + xChar;
    }

    return result;
};