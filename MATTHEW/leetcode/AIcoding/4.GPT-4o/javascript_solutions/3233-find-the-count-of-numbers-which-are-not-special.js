var countNonSpecialNumbers = function(n) {
    const isSpecial = new Array(n + 1).fill(true);
    isSpecial[0] = false;
    isSpecial[1] = false;

    for (let i = 2; i * i <= n; i++) {
        if (isSpecial[i]) {
            for (let j = i * i; j <= n; j += i) {
                isSpecial[j] = false;
            }
        }
    }

    let count = 0;
    for (let i = 2; i <= n; i++) {
        if (isSpecial[i]) count++;
    }

    return n - count;
};