var minimumOperations = function(num) {
    let n = num.length;
    let count = 0;
    let hasZero = false;
    for (let i = n - 1; i >= 0; i--) {
        if (num[i] === '0') {
            if (hasZero) {
                return n - i - 2;
            }
            hasZero = true;
        } else if (num[i] === '5') {
            for (let j = i - 1; j >= 0; j--) {
                if (num[j] === '0' || num[j] === '5') {
                    return n - j - 2;
                }
            }
        }
    }

    if (hasZero) {
        return n - 1;
    }

    return n;
};