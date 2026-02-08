var minimumOperations = function(num) {
    let res = Infinity;
    const n = num.length;

    const check = (s) => {
        let pos = 1;
        let count = 0;
        for (let i = n - 1; i >= 0; i--) {
            if (num[i] === s[pos]) {
                pos--;
                if (pos < 0) {
                    res = Math.min(res, count);
                    return;
                }
            } else {
                count++;
            }
        }
    };

    check("00");
    check("25");
    check("50");
    check("75");

    let countZero = 0;
    for (const c of num) {
        if (c === '0') countZero++;
    }
    if (countZero > 0) {
        res = Math.min(res, n - countZero);
    }

    return res === Infinity ? n : res;
};